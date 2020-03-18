import 'dart:math';
import 'package:coronajump/components/platform.dart';
import 'package:coronajump/box.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

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
    addPlatform(200.0, -250.0);
  }

  void generatePath(double levelStartHeight, double levelEndHeight) {
    var rng =
        new Random(); //TODO is it good practive to init multiple Randoms or just one per file? @tguelenman
    double currentHeight = levelStartHeight;
    while (currentHeight <= levelEndHeight) {
      double x = (rng.nextDouble() - 0.5) *
          screenWidth; //TODO uniform random double generation is used multiple times and can be extracted to function @tguelenman
      double nextStep = rng.nextDouble() * 30 +
          70; //TODO these should be parameters @tguelenman
      double y = currentHeight + nextStep;
      addPlatform(x, -y);
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(
      int numRandomPlatforms, double levelStartHeight, double levelEndHeight) {
    var rng = new Random();

    for (int i = 0; i < numRandomPlatforms; i++) {
      double x = (rng.nextDouble() - 0.5) * screenWidth;
      double y = rng.nextDouble() * (levelEndHeight - levelStartHeight) +
          levelStartHeight;
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
