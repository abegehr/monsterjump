import 'dart:math';
import 'dart:ui';
import 'package:collection/collection.dart';
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
  Size screenSize;
  bool willDestroy = false;
  // level parameters
  int levelNumber;
  double levelStartHeight;
  double levelEndHeight;
  int numRandomPlatforms;
  int numPaths;
  double movementSpeed;
  // platforms queues
  static Comparator _queueComparator = (e1, e2) => (e2.y - e1.y).toInt();
  PriorityQueue<Platform> queue = new PriorityQueue(_queueComparator);
  PriorityQueue<Platform> queueVisible = new PriorityQueue(_queueComparator);

  Level(
      this.box,
      this.levelStartHeight,
      this.levelEndHeight,
      this.numRandomPlatforms,
      this.numPaths,
      this.movementSpeed,
      this.levelNumber)
      : super();

  void init() {
    generateLevel(levelStartHeight, levelEndHeight, numRandomPlatforms,
        numPaths, movementSpeed);
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
    if (levelNumber == 0) addPlatformToQueue(0.0, -75.0);
  }

  void generatePath(double levelStartHeight, double levelEndHeight) {
    double halfScreenWidth = screenSize.width / 2;
    double currentHeight = levelStartHeight;
    while (currentHeight <= levelEndHeight) {
      double x = randomDouble(-halfScreenWidth + Platform.platformWidth / 2,
          halfScreenWidth - Platform.platformWidth / 2);
      double nextStep = randomDouble(100, 200);
      double y = currentHeight + nextStep;
      addPlatformToQueue(x, -y);
      currentHeight = y;
    }
  }

  void generateRandomPlatforms(
      int numRandomPlatforms, double levelStartHeight, double levelEndHeight) {
    for (int i = 0; i < numRandomPlatforms; i++) {
      double halfScreenWidth = screenSize.width / 2;
      double x = randomDouble(-halfScreenWidth + Platform.platformWidth / 2,
          halfScreenWidth - Platform.platformWidth / 2);
      double y = randomDouble(levelStartHeight, levelEndHeight);
      addPlatformToQueue(x, -y);
    }
  }

  void addPlatformToQueue(double x, double y) {
    queue.add(Platform(box, x, y));
  }

  void addPlatform(Platform platform) {
    queueVisible.add(platform);
    add(platform);
    box.add(platform.body);
  }

  void updateMaxHeight(double maxHeight) {
    final double upperBound = maxHeight + screenSize.height;
    final double lowerBound = maxHeight;

    while (queue.length > 0 && queue.first.y.abs() <= upperBound)
      addPlatform(queue.removeFirst());
    while (queueVisible.length > 0 && queueVisible.first.y.abs() < lowerBound)
      queueVisible.removeFirst().remove();
  }

  void remove() {
    willDestroy = true;
    components.forEach((c) {
      if (c is Platform) c.remove();
    });
  }

  @override
  bool destroy() {
    if (willDestroy) {
      queue.clear();
      queueVisible.clear();
    }
    return willDestroy;
  }

  @override
  void resize(Size size) {
    if (screenSize == null) {
      screenSize = size;
      init();
    }
    super.resize(size);
  }
}
