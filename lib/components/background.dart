import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';

class Background extends SpriteComponent {
  final double aspectRatio = 14073 / 1125;

  Background() : super.fromSprite(null, null, new Sprite('bg/background.png')) {
    anchor = Anchor.bottomCenter;
    x = 0;
  }

  @override
  void resize(Size size) {
    width = size.width;
    height = aspectRatio * width;
    y = size.height;
  }
}
