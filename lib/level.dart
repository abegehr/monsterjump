import 'dart:math';
import 'dart:ui';
import 'package:coronajump/components/platform.dart';
import 'package:coronajump/box.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';

class Level extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;
  Box box;
  bool willDestroy = false;

  Level(this.box) : super();

  void addPlatform(double x, double y) {
    Platform platform = Platform(box, x, y);
    add(platform);
    box.add(platform.body);
  }

  void generateLevel(int levelNumber) {
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
    generatePath(levelStartHeight, levelEndHeight, screenSize.width);

    // generate randomPlatforms
    generateRandomPlatforms(
        numRandomPlatforms, levelStartHeight, levelEndHeight, screenSize.width);
    addPlatform(200.0, -250.0);

    print(screenSize.toString());
  }

  void generatePath(
      double levelStartHeight, double levelEndHeight, double width) {
    var rng = new Random();
    double currentHeight = levelStartHeight;
    while (currentHeight <= levelEndHeight) {
      double x = (rng.nextDouble() - 0.5) * width;
      double nextStep = rng.nextDouble() * 30 + 70;
      double y = currentHeight + nextStep;
      addPlatform(x, -y);
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(double numRandomPlatforms,
      double levelStartHeight, double levelEndHeight, double width) {
    var rng = new Random();

    for (int i = 0; i < numRandomPlatforms; i++) {
      double x = (rng.nextDouble() - 0.5) * width;
      double y = rng.nextDouble() * (levelEndHeight - levelStartHeight) +
          levelStartHeight;
      /*
      print("Generating random platform at (" +
          x.toString() +
          "," +
          y.toString() +
          ").");
          */
      addPlatform(x, -y);
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    box.resize(size);

    for (int j = 0; j <= 1; j++)
      generateLevel(j); //TODO pass screensize from game
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
