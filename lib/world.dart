import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:coronajump/components/player.dart';

class World extends Box2DComponent {
  Size screenSize;
  Player player;
  World() : super();

  void initializeWorld() {
    //add(new Background());
    add(player = new Player(this));
  }

  @override
  void update(t) {
    super.update(t);
    // move up camera?
    print(viewport.center.y);
    print(player.body.position.y);
    viewport.setCamera(
        0.5 * screenSize.width,
        max(viewport.center.y,
            player.body.position.y + 0.5 * screenSize.height),
        1);
  }

  void handleTap(Offset position) {
    player.body
        .applyLinearImpulse(new Vector2(0, 10000), new Vector2(0, 0), true);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
