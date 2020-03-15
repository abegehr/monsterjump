import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:box2d_flame/box2d.dart';

class Platform extends SpriteComponent {
  PlatformBody body;

  Platform(box, double x, double y)
      : super.fromSprite(72, 12, new Sprite('platform/platform.png')) {
    anchor = Anchor.topCenter;
    this.x = x;
    this.y = y;
    body = PlatformBody(box, this);
  }
}

class PlatformBody extends BodyComponent {
  SpriteComponent sprite;

  PlatformBody(box, this.sprite) : super(box) {
    _createBody();
  }

  void _createBody() {
    final shape = new CircleShape(); //TODO
    shape.radius = 0.5 * 72;
    shape.p.x = 0.0;

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.density = 0.05;
    fixtureDef.friction = 0.2;
    final bodyDef = new BodyDef();
    bodyDef.linearVelocity = new Vector2(0.0, 0.0);
    bodyDef.position = new Vector2(sprite.x, sprite.y);
    bodyDef.type = BodyType.STATIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    return null;
  }
}
