import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:coronajump/utils/globals.dart';
import 'package:sensors/sensors.dart';

const num SIZE = 48.0;

class Player extends SpriteComponent {
  PlayerBody body;
  bool willDestroy = false;
  double sensorScale = 5;
  Vector2 acceleration = Vector2.zero();

  Player(Box2DComponent box)
      : super.fromSprite(SIZE, SIZE, new Sprite("virus/virus.png")) {
    anchor = Anchor.center;
    x = 0;
    y = -160;
    body = PlayerBody(box, this);
  }

  void start() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      //Adding up the scaled sensor data to the current acceleration
      acceleration.add(Vector2(event.y / sensorScale, 0));
    });
  }

  @override
  void update(double t) {
    super.update(t);
    body.body.applyForceToCenter(acceleration);
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

class PlayerBody extends BodyComponent {
  SpriteComponent sprite;
  Fixture fixture;

  PlayerBody(Box2DComponent box, this.sprite) : super(box) {
    _createBody();
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = 0.5 * SIZE * Globals.ptm;

    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.density = 0.05;
    fixtureDef.friction = 0.0;
    final bodyDef = new BodyDef();
    bodyDef.position =
        new Vector2(sprite.x * Globals.ptm, sprite.y * Globals.ptm);
    bodyDef.type = BodyType.DYNAMIC;

    body = world.createBody(bodyDef);
    fixture = body.createFixtureFromFixtureDef(fixtureDef);
    fixture.userData = {'type': "player"};
  }

  @override
  void render(Canvas canvas) {
    /*
    CircleShape shape = body.getFixtureList().getShape();
    Paint paint = Paint()..color = const Color(0x99FF0000);
    canvas.drawCircle(
        Offset(body.position.x, body.position.y), shape.radius, paint);
    */
  }

  @override
  void update(num t) {
    // update sprite position
    sprite.x = body.position.x * Globals.mtp;
    sprite.y = body.position.y * Globals.mtp;
  }

  void remove() {
    box.remove(this);
  }
}
