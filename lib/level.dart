import 'dart:math';
import 'dart:ui';

import 'package:coronajump/components/platform.dart';
import 'package:coronajump/world.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

class Level extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;
  World world;

  Level(this.world) : super() {
    //for (int i = 1; i <= 999; i++) addPlatform(0, -100.0 * i);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(world, x, y);
    add(platform);
    world.add(platform.body);
  }

  void generateLevel(int levelNumber) {
    // levelHeight: 0 -> 8k, 1 -> 7k, 2 -> 6k, 3 -> 8k, ...
    int levelHeight = (8 - (levelNumber % 3)) * 1000;

    // amount of random platforms
    int numRandomPlatforms = max(25, 80 - levelNumber * 5);

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

    print("Level " +
        levelNumber.toString() +
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

    // generate safe path
    generatePath(levelStartHeight, levelEndHeight);
    generatePath(levelStartHeight, levelEndHeight);
 
    // generate randomPlatforms
    generateRandomPlatforms(
        numRandomPlatforms, levelStartHeight, levelEndHeight);
  }

  void generatePath(levelStartHeight, levelEndHeight) {
    var rng = new Random();
    for (int currentHeight = levelStartHeight;
        currentHeight <= levelEndHeight;) {
      int x = rng.nextInt((screenSize.width + 72).toInt()) - 72;
      int nextStep = rng.nextInt(11) + 6;
      int y = currentHeight + nextStep;
      addPlatform(x.toDouble(), y.toDouble());
      print("Generating safe path platform at height " + y.toString());
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(
      numRandomPlatforms, levelStartHeight, levelEndHeight) {
    var rng = new Random();

    for (int i = 0; i < numRandomPlatforms; i++) {
      // 72 is the width of platforms
      int x = rng.nextInt((screenSize.width + 72).toInt()) - 72;
      int y = rng.nextInt(levelEndHeight - levelStartHeight) + levelStartHeight;
      print("Generating random platform at (" +
          x.toString() +
          "," +
          y.toString() +
          ").");
      addPlatform(x.toDouble(), -y.toDouble());
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    world.resize(size);

    for (int j = 0; j <= 1; j++)
      generateLevel(j); //TODO pass screensize from game
  }
}
