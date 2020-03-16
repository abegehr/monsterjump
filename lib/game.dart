import 'dart:ui';
import 'package:coronajump/level.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:coronajump/overlays/menu_overlay.dart';

class CoronaJump extends BaseGame with HasWidgetsOverlay {
  Size screenSize;
  World world = new World();
  bool playing = false;
  Player player;

  CoronaJump() {
    world.initializeWorld();

    add(new Background());
    add(new Level(world));

    addWidgetOverlay("Menu", MenuOverlay(start: start));
  }

  void start() {
    print("START GAME");
    removeWidgetOverlay("Menu");

    playing = true;
    addPlayer();
  }

  void addPlayer() {
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
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);

    if (playing) {
      // move up camera so player stays in lower screen half
      if (screenSize != null)
        camera =
            new Position(0, min(camera.y, player.y + 0.5 * screenSize.height));

      // test if player dies
      if (playing && player.y > camera.y) player.die();
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    world.resize(size);
  }
}
