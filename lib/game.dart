import 'package:flame/game.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:coronajump/components/platform.dart';

class CoronaJump extends BaseGame {
  CoronaJump() {
    add(new Background());
    add(new Player());
    add(new Platform());
  }
}
