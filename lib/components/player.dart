import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteComponent {
  Player() : super.fromSprite(48, 48, new Sprite('virus/virus.png')) {
    this.anchor = Anchor.bottomCenter;
  }

  @override
  void resize(Size size) {
    this.x = size.width * 0.5;
    this.y = size.height - 100;
  }
}
