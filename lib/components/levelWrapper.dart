import 'dart:math';
import 'dart:ui';
import 'package:coronajump/world.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';
import 'level.dart';

class LevelWrapper extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;
  World world;

  LevelWrapper(this.world) : super();

  void buildLevel(int levelNumber) {
    // levelHeight: 0 -> 8k, 1 -> 7k, 2 -> 6k, 3 -> 8k, ...
    int levelHeight = (8 - (levelNumber % 3)) * 1000;

    // amount of random platforms
    int numRandomPlatforms = max(10, 25 - levelNumber * 5);

    // movementSpeed
    double movementSpeed = min(1.5, 1 + levelNumber ~/ 2 * 0.05);
    //TODO set movementSpeed (Anton)

    // level bounds in pixel
    int levelStartHeight = (((levelNumber + 2) ~/ 3 * 8) +
                ((levelNumber + 1) ~/ 3 * 7) +
                (levelNumber ~/ 3 * 6))
            .toInt() *
        1000;
    int levelEndHeight = levelStartHeight + levelHeight - 1;

    double screenWidth = screenSize.width;

    Level level = Level(world, screenWidth, levelStartHeight, levelEndHeight,
        numRandomPlatforms, movementSpeed);
    add(level);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);

    for (int j = 0; j <= 1; j++) buildLevel(j); //TODO pass screensize from game
  }
}
