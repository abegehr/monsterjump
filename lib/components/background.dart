import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';

double bgAspectRatio = 14073 / 1125;

class BackgroundTile extends SpriteComponent {
  BackgroundTile(double y)
      : super.fromSprite(100, 200, new Sprite('bg/background.png')) {
    anchor = Anchor.bottomCenter;
    x = 0;
    this.y = y;
  }

  @override
  void resize(Size size) {
    width = size.width;
    height = bgAspectRatio * width;
  }
}

class Background extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;

  BackgroundTile tile1;
  BackgroundTile tile2;

  Background() : super() {
    add(tile1 = new BackgroundTile(0));
    add(tile1 = new BackgroundTile(0));
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    components.forEach((c) => c.resize(size));
  }
}
