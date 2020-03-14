import 'dart:ui';
import 'package:flame/game.dart';
import 'package:coronajump/components/background.dart';

class CoronaJump extends BaseGame {
  CoronaJump() {
    add(new Background());
  }
}
