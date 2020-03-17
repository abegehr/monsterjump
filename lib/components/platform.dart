import 'dart:ui';
import 'package:coronajump/utils/globals.dart';
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:box2d_flame/box2d.dart';

class Platform extends SpriteComponent {
  PlatformBody body;
  bool willDestroy = false;

  Platform(Box2DComponent box, double x, double y)
      : super.fromSprite(72, 12, new Sprite('platform/platform.png')) {
    anchor = Anchor.topCenter;
    this.x = x;
    this.y = y;
    body = PlatformBody(box, this);
  }

  void remove() {
    willDestroy = true;
    body.remove();
  }

  @override
  bool destroy() {
    print("platform.destroy() called.");
    return willDestroy;
  }
}

class PlatformBody extends BodyComponent {
  SpriteComponent sprite;
  Fixture fixture;

  PlatformBody(Box2DComponent box, this.sprite) : super(box) {
    _createBody();
  }

  void _createBody() {
    final shape = new EdgeShape();
    final hw = 0.5 * sprite.width * Globals.ptm;
    shape.set(new Vector2(-hw, 0), new Vector2(hw, 0));

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    final bodyDef = new BodyDef();
    bodyDef.position =
        new Vector2(sprite.x * Globals.ptm, sprite.y * Globals.ptm);
    bodyDef.type = BodyType.STATIC;

    body = world.createBody(bodyDef);
    fixture = body.createFixtureFromFixtureDef(fixtureDef);
    fixture.userData = {'type': "platform"};
  }

  @override
  void render(Canvas canvas) {
    /*
    EdgeShape shape = body.getFixtureList().getShape();
    Paint paint = Paint()..color = const Color(0xFFFF0000);
    canvas.drawLine(
        Offset(body.position.x + shape.vertex1.x,
            body.position.y + shape.vertex1.y),
        Offset(body.position.x + shape.vertex2.x,
            body.position.y + shape.vertex2.y),
        paint);
    */
  }

  void remove() {
    box.remove(this);
  }
}
