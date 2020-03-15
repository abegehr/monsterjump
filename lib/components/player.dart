import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/painting.dart';

class Player extends BodyComponent {
  static const num PLAYER_RADIUS = 24.0;
  Image image;

  Player(Box2DComponent box) : super(box) {
    _loadImage();
    _createBody();
  }

  void _loadImage() {
    Flame.images.load("virus/virus.png").then((img) => image = img);
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = PLAYER_RADIUS;
    shape.p.x = 0.0;

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.density = 0.05;
    fixtureDef.friction = 0.2;
    final bodyDef = new BodyDef();
    bodyDef.linearVelocity = new Vector2(0.0, 0.0);
    bodyDef.position = new Vector2(0.0, 15.0);
    bodyDef.type = BodyType.DYNAMIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (image == null) return;

    paintImage(
        canvas: canvas,
        image: image,
        rect: new Rect.fromCircle(center: center, radius: radius));
  }

  @override
  void resize(Size size) {
    body.setTransform(new Vector2(size.width * 0.5, size.height - 100), 0);
  }
}
