import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
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
    canvas.translate(0.5 * screenSize.width, 0);
    super.render(canvas);
    world.render(canvas);
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);
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
    world.handleTap(details.globalPosition);
  }
}
