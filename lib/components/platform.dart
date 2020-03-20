import 'dart:ui';
import 'package:coronajump/utils/globals.dart';
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:box2d_flame/box2d.dart';

class Platform extends SpriteComponent {
  bool willDestroy = false;
  static double platformWidth = 72.0;
  static double platformHeight = 12.0;
  // physics
  Box2DComponent box;
  final FixtureDef fixtureDef = new FixtureDef();
  Fixture fixture;
  final BodyDef bodyDef = new BodyDef();
  Body body;

  Platform(this.box, double x, double y)
      : super.fromSprite(platformWidth, platformHeight,
            new Sprite('platform/platform.png')) {
    anchor = Anchor.topCenter;
    this.x = x;
    this.y = y;
    _createBody();
  }

  void _createBody() {
    final shape = new EdgeShape();
    final hw = 0.5 * width * Globals.ptm;
    shape.set(new Vector2(-hw, 0), new Vector2(hw, 0));

    fixtureDef.shape = shape;
    bodyDef.position = new Vector2(x * Globals.ptm, y * Globals.ptm);
    bodyDef.type = BodyType.STATIC;
  }

  void addBody() {
    body = box.world.createBody(bodyDef);
    fixture = body.createFixtureFromFixtureDef(fixtureDef);
    fixture.userData = {'type': "platform"};
  }

  @override
  void render(Canvas canvas) {
    if (Globals.renderBox2DShapes && body != null) {
      EdgeShape shape = body.getFixtureList().getShape();
      Paint paint = Paint()..color = const Color(0xFFFF0000);
      canvas.drawLine(
          Offset((body.position.x + shape.vertex1.x) * Globals.mtp,
              (body.position.y + shape.vertex1.y) * Globals.mtp),
          Offset((body.position.x + shape.vertex2.x) * Globals.mtp,
              (body.position.y + shape.vertex2.y) * Globals.mtp),
          paint);
    }
    super.render(canvas);
  }

  void remove() {
    willDestroy = true;
  }

  void removeBody() {
    if (body != null) {
      box.world.destroyBody(body);
      body = null;
      fixture = null;
    }
  }

  @override
  bool destroy() {
    if (willDestroy) removeBody();
    return willDestroy;
  }
}
