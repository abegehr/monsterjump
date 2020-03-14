import 'package:flame/game.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';

class CoronaJump extends BaseGame {
  CoronaJump() {
    add(new Background());
    add(new Player());
  }
}
