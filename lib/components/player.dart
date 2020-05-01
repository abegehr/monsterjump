import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:monsterjump/utils/globals.dart';
import 'package:monsterjump/utils/movement/movement.dart';

class Player extends SpriteComponent {
  static final double size = 48.0;
  final double maxHorVel = 40;

  PlayerBody body;
  bool willDestroy = false;
  Movement movement = Movement();
  Function unsubMovement;
  double horVel = 0;

  Player(Box2DComponent box, {double x: 0, double y: -160})
      : super.fromSprite(
            Player.size, Player.size, new Sprite("virus/virus.png")) {
    anchor = Anchor.center;
    this.x = x;
    this.y = y;
    body = PlayerBody(box, this);
  }

  void start() {
    unsubMovement = movement.subHorizontalMovement((double newHorVel) {
      horVel = newHorVel;
    });
  }

  void stop() {
    if (unsubMovement != null) unsubMovement();
  }

  @override
  void update(double t) {
    super.update(t);

    // move with gyroscope
    Vector2 vel = body.body.linearVelocity;
    body.body.linearVelocity =
        Vector2(horVel.sign * min(horVel.abs(), maxHorVel), vel.y);
  }

  void remove() {
    willDestroy = true;
    body.remove();
    stop();
  }

  @override
  bool destroy() {
    return willDestroy;
  }
}

class PlayerBody extends BodyComponent {
  SpriteComponent sprite;
  Fixture fixture;
  double screenHalfWidth;
  bool willDestroy = false;

  PlayerBody(Box2DComponent box, this.sprite) : super(box) {
    _createBody();
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = 0.3 * Player.size * Globals.ptm;

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
    if (Globals.renderBox2DShapes) {
      CircleShape shape = body.getFixtureList().getShape();
      Paint paint = Paint()..color = const Color(0x99FF0000);
      canvas.drawCircle(
          Offset(body.position.x * Globals.mtp, body.position.y * Globals.mtp),
          shape.radius * Globals.mtp,
          paint);
    }
  }

  @override
  void update(num t) {
    // update sprite position
    sprite.y = body.position.y * Globals.mtp;
    double newX = body.position.x * Globals.mtp;
    // keep player in screen horizontally
    if (screenHalfWidth != null && newX.abs() > screenHalfWidth) {
      newX = -newX;
      body.setTransform(
          new Vector2(newX * Globals.ptm, body.position.y), body.getAngle());
    }
    sprite.x = newX;
  }

  void remove() {
    willDestroy = true;
  }

  @override
  bool destroy() {
    if (willDestroy) box.world.destroyBody(body);
    return willDestroy;
  }

  @override
  void resize(Size size) {
    print("size $size");
    screenHalfWidth = 0.5 * size.width;
    super.resize(size);
  }
}
