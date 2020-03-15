import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class World extends Box2DComponent {
  World() : super(gravity: 100);

  void initializeWorld() {
    world.setContactListener(CJContactListener());
  }
}

class CJContactListener extends ContactListener {
  @override
  void beginContact(Contact contact) {
    print("beginContact: $contact");
  }

  @override
  void endContact(Contact contact) {
    print("endContact: $contact");
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    print("postSolve: $contact $impulse");
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    print("preSolve: $contact $oldManifold");
  }
}
