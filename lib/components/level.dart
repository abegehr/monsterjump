import 'dart:math';
import 'package:coronajump/components/platform.dart';
import 'package:coronajump/box.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

// random double generator
var rng = new Random();
double randomDouble(double start, double end) {
  return rng.nextDouble() * (end - start).abs() + start;
}

class Level extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Box box;
  double screenWidth;
  bool willDestroy = false;
  double levelEndHeight;
  int levelNumber;

  Level(this.box, this.screenWidth, levelStartHeight, this.levelEndHeight,
      numRandomPlatforms, numPaths, movementSpeed, this.levelNumber)
      : super() {
    generateLevel(levelStartHeight, levelEndHeight, numRandomPlatforms,
        numPaths, movementSpeed);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(box, x, y);
    add(platform);
    box.add(platform.body);
  }

  void generateLevel(double levelStartHeight, double levelEndHeight,
      int numRandomPlatforms, int numPaths, double movementSpeed) {
    // generate safe path
    for (int i = 0; i < numPaths; i++)
      generatePath(levelStartHeight, levelEndHeight);

    // generate randomPlatforms
    generateRandomPlatforms(
        numRandomPlatforms, levelStartHeight, levelEndHeight);

    // generate starting platform for first level
    if (levelNumber == 0) addPlatform(0.0, -75.0);
  }

  void generatePath(double levelStartHeight, double levelEndHeight) {
    double halfScreenWidth = screenWidth / 2;
    double currentHeight = levelStartHeight;
    while (currentHeight <= levelEndHeight) {
      double x = randomDouble(-halfScreenWidth + Platform.platformWidth / 2,
          halfScreenWidth - Platform.platformWidth / 2);
      double nextStep = randomDouble(100, 200);
      double y = currentHeight + nextStep;
      addPlatform(x, -y);
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(
      int numRandomPlatforms, double levelStartHeight, double levelEndHeight) {
    for (int i = 0; i < numRandomPlatforms; i++) {
      double halfScreenWidth = screenWidth / 2;
      double x = randomDouble(-halfScreenWidth + Platform.platformWidth / 2,
          halfScreenWidth - Platform.platformWidth / 2);
      double y = randomDouble(levelStartHeight, levelEndHeight);
      addPlatform(x, -y);
    }
  }

  void remove() {
    willDestroy = true;
    components.forEach((c) {
      if (c is Platform) c.remove();
    });
  }

  @override
  bool destroy() {
    return willDestroy;
  }
}
