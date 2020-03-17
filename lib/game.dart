import 'dart:async';
import 'dart:ui';
import 'package:coronajump/level.dart';
import 'package:flame/game.dart';
import 'package:flame/game/widget_builder.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:coronajump/world.dart';
import 'package:coronajump/components/background.dart';
import 'package:coronajump/components/player.dart';
import 'package:flame/text_config.dart';
// overlays
import 'package:coronajump/overlays/menu_overlay.dart';
import 'package:coronajump/overlays/gameover_overlay.dart';
import 'package:flutter/material.dart';

class CoronaJump extends BaseGame with CJHasWidgetsOverlay {
  Size screenSize;
  Background background = new Background();
  World world = new World();
  bool playing = false;
  Player player;
  Level level;
  double maxHeight = 0;

  CoronaJump() {
    // Box2D
    world.initializeWorld();

    // background
    add(background);

    // level
    add(level = new Level(world));

    // start menu
    addWidgetOverlay("Menu", MenuOverlay(start: start));
  }

  void start() {
    if (!playing) {
      print("START GAME");
      playing = true;

      // overlays
      removeWidgetOverlay("Menu");
      removeWidgetOverlay("Gameover");

      // player
      addPlayer();
      player.start();
    }
  }

  void addPlayer() {
    add(player = new Player(world));
    world.add(player.body);
  }

  void gameover() {
    if (playing) {
      print("GAME OVER");
      playing = false;

      // overlays
      addWidgetOverlay("Gameover", GameoverOverlay(start: start));

      // player
      player.destroy();

      // level
      level.destroy();
    }
  }

  @override
  void render(Canvas canvas) {
    // move canvas origin to bottomCenter
    canvas.translate(0.5 * screenSize.width, screenSize.height);

    // render BaseGame
    super.render(canvas);

    // render Box2D incl. camera offset
    canvas.translate(-camera.x, -camera.y);
    world.render(canvas);
    canvas.restore();
    canvas.save();

    // render score //TODO use Flame TextComponent
    int score = (maxHeight / 10).floor();
    const TextConfig config = TextConfig(
        fontSize: 48.0, color: Color(0xFFFFFFFF), fontFamily: 'Awesome Font');
    config.render(canvas, "Score: $score", Position(16, 32));
  }

  @override
  void update(num t) {
    super.update(t);
    world.update(t);

    if (playing) {
      if (screenSize != null) {
        // update maxHeight
        maxHeight = min(camera.y, player.y + 0.5 * screenSize.height).abs();

        // move up camera so player stays in lower screen half
        camera = new Position(0, -maxHeight);

        // update background
        background.updateMaxHeight(maxHeight);
      }

      // test if player dies
      if (player.y > camera.y) gameover();
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
    world.resize(size);
  }
}

// TODO this is tmp until https://github.com/flame-engine/flame/issues/236 is solved
mixin CJHasWidgetsOverlay on Game {
  @override
  final builder = OverlayWidgetBuilder();

  StreamController<OverlayWidget> cjWidgetOverlayController =
      StreamController();

  void addWidgetOverlay(String overlayName, Widget widget) {
    cjWidgetOverlayController.sink.add(OverlayWidget(overlayName, widget));
  }

  void removeWidgetOverlay(String overlayName) {
    cjWidgetOverlayController.sink.add(OverlayWidget(overlayName, null));
  }
}
