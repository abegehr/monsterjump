import 'dart:ui';

import 'package:coronajump/components/platform.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

class Level extends PositionComponent with HasGameRef, Tapable, ComposedComponent {
  bool visible = false;

  Platform platform1;
  Platform platform2;

  Level(world) : super() {
    platform1 = Platform(world, 0,-175);
    platform2 = Platform(world, 0, -275);
    components..add(platform1)..add(platform2);
  }

  @override
  void render(Canvas canvas) {
    if (visible) {
      super.render(canvas);
    } // If not, neither of its `components` will be rendered
  }
}