import 'dart:collection';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';

double bgAspectRatio = 14073 / 1125;

class BackgroundTile extends SpriteComponent {
  BackgroundTile(double y)
      : super.fromSprite(100, 200, new Sprite('bg/background.png')) {
    anchor = Anchor.bottomCenter;
    x = 0;
    this.y = y;
  }

  @override
  void resize(Size size) {
    width = size.width;
    height = bgAspectRatio * width;
  }
}

class Background extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  Size screenSize;

  Queue<BackgroundTile> queue;

  Background() : super() {
    queue = Queue.from([new BackgroundTile(0), new BackgroundTile(0)]);
    queue.forEach((tile) {
      add(tile);
    });
  }

  void reset() {
    queue.forEach((tile) {
      tile.y = 0;
    });
  }

  updateMaxHeight(double maxHeight) {
    double tol = 16.0;
    BackgroundTile lastTile = queue.last;
    double upperBound = lastTile.y.abs() + lastTile.width * bgAspectRatio - tol;
    if (upperBound - screenSize.height < maxHeight) {
      // move up the lowest BackgroundTile
      BackgroundTile tile = queue.removeFirst();
      tile.y = -upperBound;
      queue.add(tile);
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    components.forEach((c) => c.resize(size));
  }
}
