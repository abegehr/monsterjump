import 'package:coronajump/components/player.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class World extends Box2DComponent {
  CJContactFilter contactFilter = CJContactFilter();

  World() : super(gravity: 100);

  @override
  void initializeWorld() {
    world.setContactFilter(contactFilter);
  }

  void addPlayerBody(PlayerBody playerBody) {
    add(playerBody);
    contactFilter.playerFixture = playerBody.fixture;
  }
}

class CJContactFilter extends ContactFilter {
  Fixture playerFixture;

  @override
  bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
    print("shouldCollide $fixtureA $fixtureB");
    if (fixtureA == playerFixture) print("fixtureA");
    if (fixtureB == playerFixture) print("fixtureB");

    return true;
  }
}
