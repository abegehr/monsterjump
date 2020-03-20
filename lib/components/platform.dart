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
  static double platformWidth = 72.0;
  static double platformHeight = 12.0;
  Box2DComponent box;

  Platform(this.box, double x, double y)
      : super.fromSprite(platformWidth, platformHeight,
            new Sprite('platform/platform.png')) {
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
    return willDestroy;
  }
}

class PlatformBody extends BodyComponent {
  SpriteComponent sprite;
  Fixture fixture;
  bool willDestroy = false;

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
    if (Globals.renderBox2DShapes) {
      EdgeShape shape = body.getFixtureList().getShape();
      Paint paint = Paint()..color = const Color(0xFFFF0000);
      canvas.drawLine(
          Offset((body.position.x + shape.vertex1.x) * Globals.mtp,
              (body.position.y + shape.vertex1.y) * Globals.mtp),
          Offset((body.position.x + shape.vertex2.x) * Globals.mtp,
              (body.position.y + shape.vertex2.y) * Globals.mtp),
          paint);
    }
  }

  void remove() {
    willDestroy = true;
  }

  @override
  bool destroy() {
    if (willDestroy) {
      Body currentEl = box.world.bodyList;
      int i = 1;
      while (currentEl != null) {
        currentEl = currentEl.getNext();
        i++;
      }
      print("DEBUG count before box destroy: " + i.toString());

      //
      box.world.destroyBody(
          body); //TODO where should box.remove() be used? https://github.com/flame-engine/flame/issues/17#issuecomment-406700417

      int j = 1;
      currentEl = box.world.bodyList;
      while (currentEl != null) {
        currentEl = currentEl.getNext();
        j++;
      }
      print("DEBUG count after box destroy: " + j.toString());
      //
    }

    return willDestroy;
  }
}
