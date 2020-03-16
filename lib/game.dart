import 'dart:ui';
import 'package:coronajump/level.dart';
import 'package:coronajump/view.dart';
import 'package:coronajump/views/home-view.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:coronajump/components/start-button.dart';

class CoronaJump extends BaseGame {
  Size screenSize;
  double tileSize;
  World world = new World();
  Player player;

  View activeView = View.home;

  HomeView homeView;

  StartButton startButton;

  CoronaJump() {
    world.initializeWorld();

    add(new Background());

    // level
    add(new Level(world));

    // player
    add(player = new Player(world));
    world.add(player.body);

    homeView = HomeView(this);

    startButton = StartButton(this);
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

    if (activeView == View.home) homeView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);

    // move up camera so player stays in lower screen half
    if (screenSize != null)
      camera =
          new Position(0, min(camera.y, player.y + 0.5 * screenSize.height));

    if (player.y > camera.y) player.die();
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    world.resize(size);
    tileSize = screenSize.width / 9;
  }
}
