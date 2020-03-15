import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';

class CoronaJump extends BaseGame {
  Size screenSize;
  World world = new World();
  Player player;

  CoronaJump() {
    add(new Background());
    // player
    add(player = new Player(world));
    world.add(player.body);
  }

  @override
  void render(Canvas canvas) {
    canvas.translate(0.5 * screenSize.width, screenSize.height);
    super.render(canvas);
    world.render(canvas);
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);

    // move up camera?
    camera = new Position(0, min(camera.y, player.y + 0.5 * screenSize.height));
  }

  void handleTap(Offset position) {}

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
