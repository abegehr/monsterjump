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

class LevelWrapper extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;
  Box box;
  bool willDestroy = false;
  Queue<Level> queue;

  LevelWrapper(this.box) : super();

  void initLevels() {
    queue = Queue.from([buildLevel(0), buildLevel(1)]);
    queue.forEach((q) => add(q));
  }

  Level buildLevel(int levelNumber) {
    // levelHeight: 0 -> 8k, 1 -> 7k, 2 -> 6k, 3 -> 8k, ...
    double levelHeight = (8 - (levelNumber % 3)) * 1000.0;

    // amount of random platforms
    int numRandomPlatforms = max(10, 25 - levelNumber * 5);

    // amount of safe paths
    int numPaths = max(1, 3 - levelNumber);

    // movementSpeed
    double movementSpeed = min(1.5, 1 + levelNumber ~/ 2 * 0.05);
    //TODO? set movementSpeed

    // level bounds in pixel
    double levelStartHeight = (((levelNumber + 2) ~/ 3 * 8) +
            ((levelNumber + 1) ~/ 3 * 7) +
            (levelNumber ~/ 3 * 6)) *
        1000.0;
    double levelEndHeight = levelStartHeight + levelHeight - 1;

    Level level = Level(box, levelStartHeight, levelEndHeight,
        numRandomPlatforms, numPaths, movementSpeed, levelNumber);
    add(level);
    return level;
  }

  void updateMaxHeight(double maxHeight) {
    Level last = queue.last;
    double upperBound = last.levelEndHeight.abs();
    if (upperBound - screenSize.height < maxHeight) {
      // remove lowest Level, add another one on top
      queue.removeFirst().remove();
      queue.add(buildLevel(last.levelNumber + 1));
    }

    // update levels
    queue.forEach((level) {
      level.updateMaxHeight(maxHeight);
    });
  }

  void remove() {
    willDestroy = true;
    removeComponents();
  }

  removeComponents() {
    components.forEach((c) {
      if (c is Level) c.remove();
    });
  }

  @override
  bool destroy() {
    return willDestroy;
  }

  @override
  void resize(Size size) {
    if (screenSize == null || screenSize != size) {
      screenSize = size;
      removeComponents();
      initLevels();
    }
    super.resize(size);
  }
}
