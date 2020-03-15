import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/painting.dart';

const double SIZE = 48;

class Player extends SpriteComponent {
  Size screenSize;
  PlayerBody body;

  Player(box) : super.fromSprite(SIZE, SIZE, new Sprite("virus/virus.png")) {
    body = PlayerBody(box, this);
  }

  @override
  void update(double t) {
    if (this.y < -0.5 * screenSize.height) {
      print("!!!DEAD!!!"); //TODO
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);

    x = 0.5 * screenSize.width;
    y = 100;
    body.body.setTransform(new Vector2(0, 100 - size.height * 0.5), 0);
  }
}

class PlayerBody extends BodyComponent {
  SpriteComponent sprite;

  PlayerBody(box, this.sprite) : super(box) {
    _createBody();
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = 0.5 * SIZE;
    shape.p.x = 0.0;

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.density = 0.05;
    fixtureDef.friction = 0.2;
    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(0.0, 0.0);
    bodyDef.linearVelocity = new Vector2(0.0, 0.0);
    bodyDef.type = BodyType.DYNAMIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void update(double t) {
    // update sprite position
    sprite.x = body.position.x;
    sprite.y = body.position.y;
  }
}
