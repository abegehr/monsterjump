import 'dart:ui';
import 'package:monsterjump/components/level_wrapper.dart';
import 'package:monsterjump/utils/admob.dart';
import 'package:monsterjump/utils/score.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'dart:math';
import 'package:monsterjump/box.dart';
import 'package:monsterjump/components/background.dart';
import 'package:monsterjump/components/player.dart';
import 'package:flame/text_config.dart';
import 'package:wakelock/wakelock.dart';
// overlays
import 'package:monsterjump/overlays/menu_overlay.dart';
import 'package:monsterjump/overlays/gameover_overlay.dart';
import 'package:monsterjump/landing_page.dart';

class CoronaJump extends BaseGame with HasWidgetsOverlay {
  Size screenSize;
  Background background = new Background();
  Box box = new Box();
  bool playing = false;
  Player player;
  LevelWrapper level;
  double maxHeight = 0;
  int score = 0;

  CoronaJump() {
    // Box2D
    box.initializeWorld();

    // background
    add(background);

    // landingpage
    showLandingPage();
  }

  void showLandingPage() {
    addWidgetOverlay(
        "Page", LandingPage(goHome: showMenuOverlay)); //start: start
  }

  void showMenuOverlay() {
    removeWidgetOverlay("Page");
    removeWidgetOverlay("Gameover");
    addWidgetOverlay("Menu", MenuOverlay(start: start));
    Admob.showBannerAd();
  }

  void showGameoverOverlay() {
    removeWidgetOverlay("Menu");
    addWidgetOverlay("Gameover",
        GameoverOverlay(restart: start, goHome: showMenuOverlay, score: score));
    Admob.showBannerAd();
  }

  void hideOverlay() {
    removeWidgetOverlay("Menu");
    removeWidgetOverlay("Gameover");
    Admob.removeBannerAd();
    Admob.loadBannerAd();
  }

  void start() {
    if (!playing) {
      print("START GAME");
      playing = true;
      maxHeight = 0;
      score = 0;

      // overlays
      hideOverlay();

      // background
      background.reset();

      // level
      add(level = new LevelWrapper(box));

      // player
      addPlayer();
      player.start();

      // To keep the screen on:
      Wakelock.enable();
    }
  }

  void addPlayer() {
    addLater(player = new Player(box, y: -(maxHeight + 160)));
    box.add(player.body);
  }

  void gameover() {
    if (playing) {
      print("GAME OVER");
      playing = false;

      // save score
      Score.saveScore(score);

      // overlay
      showGameoverOverlay();
      // player
      player.remove();
      // level
      level.remove();

      // To let the screen turn off again:
      Wakelock.disable();
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
    box.render(canvas);
    canvas.restore();
    canvas.save();

    // render score //TODO use Flame TextComponent
    const TextConfig config = TextConfig(
        fontSize: 48.0, color: Color(0xFFFFFFFF), fontFamily: 'Awesome Font');
    config.render(canvas, "Score: $score", Position(16, 32));
  }

  @override
  void update(num t) {
    super.update(t);
    box.update(t);

    if (playing) {
      if (screenSize != null) {
        // update maxHeight and score
        maxHeight = min(-maxHeight, player.y + 0.5 * screenSize.height).abs();
        score = (maxHeight / 10).floor();

        // move up camera so player stays in lower screen half
        camera = new Position(0, -maxHeight);

        // update background
        background.updateMaxHeight(maxHeight);

        // update levels
        level.updateMaxHeight(maxHeight);
      }

      // test if player dies
      if (player.y > camera.y) gameover();
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(screenSize);
    box.resize(screenSize);
  }
}
