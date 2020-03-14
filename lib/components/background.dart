import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Background extends SpriteComponent {
  final double aspectRatio = 1125 / 14073;

  Background() : super.fromSprite(null, null, new Sprite('bg/background.png')) {
    this.anchor = Anchor.bottomLeft;
    this.x = 0;
  }

  @override
  void resize(Size size) {
    this.width = size.width;
    this.height = this.aspectRatio * this.width;
    this.y = size.height;
  }
}
