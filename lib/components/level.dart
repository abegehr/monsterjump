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
  double screenWidth;

  Level(this.world, this.screenWidth, levelStartHeight, levelEndHeight,
      numRandomPlatforms, movementSpeed)
      : super() {
    generateLevel(
        levelStartHeight, levelEndHeight, numRandomPlatforms, movementSpeed);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(world, x, y);
    add(platform);
    world.add(platform.body);
  }

  void generateLevel(int levelStartHeight, int levelEndHeight,
      int numRandomPlatforms, double movementSpeed) {
    // generate safe path
    generatePath(levelStartHeight, levelEndHeight);

    // generate randomPlatforms
    generateRandomPlatforms(
        numRandomPlatforms, levelStartHeight, levelEndHeight);
    addPlatform(200.0, -250.0);
  }

  void generatePath(levelStartHeight, levelEndHeight) {
    var rng = new Random();
    int currentHeight = levelStartHeight;
    while (currentHeight <= levelEndHeight) {
      int x = (rng.nextInt(screenWidth.toInt()) - screenWidth / 2).toInt();
      int nextStep = rng.nextInt(30) + 70;
      int y = currentHeight + nextStep;
      addPlatform(x.toDouble(), -y.toDouble());
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(
      numRandomPlatforms, levelStartHeight, levelEndHeight) {
    var rng = new Random();

    for (int i = 0; i < numRandomPlatforms; i++) {
      int x = (rng.nextInt(screenWidth.toInt()) - screenWidth / 2).toInt();
      int y = rng.nextInt(levelEndHeight - levelStartHeight) + levelStartHeight;
      print("Generating random platform at (" +
          x.toString() +
          "," +
          y.toString() +
          ").");
      addPlatform(x.toDouble(), -y.toDouble());
    }
  }
}
