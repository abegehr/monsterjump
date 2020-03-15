import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class World extends Box2DComponent {
  World() : super(gravity: 100);

  @override
  void initializeWorld() {
    world.setContactFilter(CJContactFilter());
  }
}

class CJContactFilter extends ContactFilter {
  @override
  bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
    print("shouldCollide $fixtureA $fixtureB");
    return true;
  }
}
