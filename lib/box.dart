import 'dart:ui';

import 'package:coronajump/utils/globals.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class Box extends Box2DComponent {
  Size screenSize;
  CJContactFilter contactFilter = CJContactFilter();

  Box() : super(gravity: 18.0);

  @override
  void initializeWorld() {
    world.setContactFilter(contactFilter);
  }

  void preAdd(BodyComponent c) {
    if (screenSize != null) c.resize(screenSize);
  }

  @override
  void add(BodyComponent c) {
    preAdd(
        c); //TODO this should be part of Box2DComponent implementation (see BaseGame)
    super.add(c);
  }

  @override
  void update(double t) {
    components.removeWhere((c) => c
        .destroy()); //TODO this should be part of Box2DComponent implementation (see BaseGame)
    super.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
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
        Body platformBody = platformFixture.getBody();
        Shape playerShape = playerFixture.getShape();

        double playerVY = playerBody.linearVelocity.y;
        double platformY = platformBody.position.y;
        double playerRadius = playerShape.radius;
        double playerY = playerBody.position.y;
        double playerBottomY = playerY + playerRadius;

        double tol = 2 * Globals.ptm;
        if (playerVY < 0 || playerBottomY > platformY + tol) {
          // player is moving up or playerBottom is below platform w/ tol
          return false;
        } else {
          // player touched down on platform -> jump

          /*playerBody.applyLinearImpulse(new Vector2(0, -24 * playerBody.mass),
              playerBody.worldCenter, true);*/
          playerBody.linearVelocity =
              new Vector2(playerBody.linearVelocity.x, -Globals.jumpVY);
        }
      }
    }

    return true;
  }
}
