import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Platform extends SpriteComponent {
  Platform() : super.fromSprite(72, 12, new Sprite('platform/platform.png')) {
    this.anchor = Anchor.bottomCenter;
  }

  @override
  void resize(Size size) {
    this.x = size.width * 0.7;
    this.y = size.height - 100;
  }
}
