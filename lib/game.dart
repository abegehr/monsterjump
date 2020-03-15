import 'dart:ui';
import 'package:flame/game.dart';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';

class CoronaJump extends BaseGame {
  World world = World();

  CoronaJump() {
    add(new Background());
    world.initializeWorld();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    world.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    world.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    world.resize(size);
  }
}
