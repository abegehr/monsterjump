import 'dart:math';

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
    for (int i = 1; i <= 999; i++) addPlatform(0, -100.0 * i);
    for (int j = 0; j <= 12; j++) generateLevel(j);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(world, x, y);
    add(platform);
    world.add(platform.body);
  }

  void generateLevel(int i) {
    // i = level number; 0 to inf

    // levelHeight: 0 -> 8k, 1 -> 7k, 2 -> 6k, 3 -> 8k, ...
    int levelHeight = (8 - (i % 3)) * 1000;

    // amount of random platforms
    int numRandomPlatforms = max(25, 80 - i * 5);

    // movementSpeed
    double movementSpeed = min(1.5, 1 + i ~/ 2 * 0.05);
    //TODO set movementSpeed (Anton)

    // level bounds in pixel
    int levelStartHeight =
        (((i + 2) ~/ 3 * 8) + ((i + 1) ~/ 3 * 7) + ((i) ~/ 3 * 6)).toInt() *
            1000;
    int levelEndHeight = levelStartHeight + levelHeight - 1;

    print("Level " +
        i.toString() +
        ": height = " +
        levelHeight.toString() +
        "; numRandomPlatforms: " +
        numRandomPlatforms.toString() +
        "; movementSpeed: " +
        movementSpeed.toString() +
        "; levelStartHeight: " +
        levelStartHeight.toString() +
        "; levelEndHeight: " +
        levelEndHeight.toString());

    //TODO generate safe path

    //TODO generate randomPlatforms
  }
}
