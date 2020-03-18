import 'dart:collection';
import 'dart:math';
import 'dart:ui';
import 'package:coronajump/box.dart';
import 'package:coronajump/components/platform.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/composed_component.dart';
import 'level.dart';

double bgAspectRatio = 14073 / 1125;

class LevelWrapper extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;
  Box box;
  bool willDestroy = false;
  Queue<Level> queue;

  LevelWrapper(this.box) : super();

  updateMaxHeight(double maxHeight) {
    Level lastLevel = queue.last;
    double upperBound = lastLevel.levelEndHeight.abs();
    if (upperBound - screenSize.height < maxHeight) {
      // remove lowest Level, add another one on top
      queue.removeFirst();
      int nextLevelNumber = lastLevel.levelNumber + 1;
      Level nextLevel = buildLevel(nextLevelNumber);
      queue.add(nextLevel);
    }
  }

  Level buildLevel(int levelNumber) {
    // levelHeight: 0 -> 8k, 1 -> 7k, 2 -> 6k, 3 -> 8k, ...
    int levelHeight = (8 - (levelNumber % 3)) * 1000;

    // amount of random platforms
    int numRandomPlatforms = max(10, 25 - levelNumber * 5);

    // amount of safe paths
    int numPaths = 1;

    // movementSpeed
    double movementSpeed = min(1.5, 1 + levelNumber ~/ 2 * 0.05);
    //TODO? set movementSpeed

    // level bounds in pixel
    double levelStartHeight = (((levelNumber + 2) ~/ 3 * 8) +
            ((levelNumber + 1) ~/ 3 * 7) +
            (levelNumber ~/ 3 * 6)) *
        1000.0;
    double levelEndHeight = levelStartHeight + levelHeight - 1;

    double screenWidth = screenSize.width;

    Level level = Level(box, screenWidth, levelStartHeight, levelEndHeight,
        numRandomPlatforms, numPaths, movementSpeed, levelNumber);
    add(level);
    return level;
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);

    // for (int j = 0; j <= 1; j++) buildLevel(j); //TODO pass screensize from game
    queue = Queue.from([buildLevel(0), buildLevel(1)]);
    queue.forEach((q) => add(q));
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
