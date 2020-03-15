import 'dart:ui';
import 'package:flame/box2d/box2d_component.dart';

class World extends Box2DComponent {
  Size screenSize;
  World() : super(gravity: 10);

  void initializeWorld() {}

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
