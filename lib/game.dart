import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:coronajump/components/platform.dart';

class CoronaJump extends BaseGame {
  Size screenSize;
  World world = new World();
  Player player;

  CoronaJump() {
    add(new Background());

    // DEBUG platforms
    Platform platform1 = new Platform(world, 0, -75);
    add(platform1);
    world.add(platform1.body);
    Platform platform2 = new Platform(world, 0, -200);
    add(platform2);
    world.add(platform2.body);

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
  }

  @override
  void onTapUp(TapUpDetails details) {
    super.onTapUp(details);

    player.jump(); //DEBUG
  }
}
