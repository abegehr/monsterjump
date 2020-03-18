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

  Level(this.box, this.screenWidth, levelStartHeight, levelEndHeight,
      numRandomPlatforms, numPaths, movementSpeed)
      : super() {
    generateLevel(levelStartHeight, levelEndHeight, numRandomPlatforms,
        numPaths, movementSpeed);
  }

  void addPlatform(double x, double y) {
    Platform platform = Platform(box, x, y);
    add(platform);
    box.add(platform.body);
  }

  void generateLevel(int levelStartHeight, int levelEndHeight,
      int numRandomPlatforms, int numPaths, double movementSpeed) {
    // generate safe path
    for (int i = 0; i < numPaths; i++)
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
      addPlatform(x.toDouble(), -y.toDouble());
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
