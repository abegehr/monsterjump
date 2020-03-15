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
    final shape = new EdgeShape();
    final x = sprite.x;
    final y = sprite.y;
    final hw = 0.5 * sprite.width;
    shape.set(new Vector2(x - hw, y), new Vector2(x + hw, y));

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(sprite.x, sprite.y);
    bodyDef.type = BodyType.STATIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    //DEBUG
    EdgeShape shape = body.getFixtureList().getShape();
    print("platform 1 ${shape.vertex1}");
    print("platform 2 ${shape.vertex2}");
    Paint paint = Paint()..color = const Color(0xFFFF0000);
    canvas.drawLine(Offset(shape.vertex1.x, shape.vertex1.y),
        Offset(shape.vertex2.x, shape.vertex2.y), paint);
  }
}
