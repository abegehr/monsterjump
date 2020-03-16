import 'dart:ui';
import 'package:coronajump/level.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:flame/text_config.dart';

class CoronaJump extends BaseGame {
  Size screenSize;
  World world = new World();
  Player player;
  double height = 0;

  CoronaJump() {
    world.initializeWorld();

    add(new Background());

    // level
    add(new Level(world));

    // player
    add(player = new Player(world));
    world.add(player.body);
  }

  @override
  void render(Canvas canvas) {
    // move canvas origin to bottomCenter
    canvas.translate(0.5 * screenSize.width, screenSize.height);

    // render BaseGame
    super.render(canvas);

    // render Box2D incl. camera offset
    canvas.translate(-camera.x, -camera.y);
    world.render(canvas);
    canvas.restore();
    canvas.save();

    // render score //TODO use Flame TextComponent
    int score = (height / 10).floor().abs();
    const TextConfig config = TextConfig(
        fontSize: 48.0, color: Color(0xFFFFFFFF), fontFamily: 'Awesome Font');
    config.render(canvas, "Score: $score", Position(16, 32));
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);

    if (screenSize != null) {
      // update height
      height = min(camera.y, player.y + 0.5 * screenSize.height);

      // move up camera so player stays in lower screen half
      camera = new Position(0, height);

      // update background

    }

    // gameover condition
    if (player.y > camera.y) player.die();
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    world.resize(size);
  }
}
