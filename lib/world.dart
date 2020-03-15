import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class World extends Box2DComponent {
  CJContactFilter contactFilter = CJContactFilter();

  World() : super(gravity: 100);

  @override
  void initializeWorld() {
    world.setContactFilter(contactFilter);
  }
}

class CJContactFilter extends ContactFilter {
  @override
  bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
    if (fixtureA.userData != null && fixtureB.userData != null) {
      Fixture playerFixture;
      Fixture platformFixture;

      if (Map.from(fixtureA.userData)['type'] == "player" &&
          Map.from(fixtureB.userData)['type'] == "platform") {
        playerFixture = fixtureA;
        platformFixture = fixtureB;
      }
      if (Map.from(fixtureA.userData)['type'] == "platform" &&
          Map.from(fixtureB.userData)['type'] == "player") {
        platformFixture = fixtureA;
        playerFixture = fixtureB;
      }

      if (playerFixture != null && platformFixture != null) {
        // player collides with platform
        Body playerBody = playerFixture.getBody();
        Vector2 playerV = playerBody.linearVelocity;
        if (playerV.y < 0) {
          // player is moving up
          return false;
        }
      }
    }

    return true;
  }
}
