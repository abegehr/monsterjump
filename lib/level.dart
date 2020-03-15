import 'package:coronajump/components/platform.dart';
import 'package:coronajump/world.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

class Level extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  World world;

  Level(this.world) : super() {
    addPlatform(0,-175);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(world, x, y);
    add(platform);
    world.add(platform.body);
  }
}
