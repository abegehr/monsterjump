import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:monsterjump/utils/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:monsterjump/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // Admob setup
  Admob.init();
  Admob.loadBannerAd();

  // preload images
  Flame.images.loadAll(<String>[
    'bg/background.png',
    'virus/virus.png',
    'platform/platform.png'
  ]);

  // Flame settings
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // run app
  runApp(new GameContainer());
}

class GameContainer extends StatelessWidget {
  final CoronaJump game = CoronaJump();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 420),
        child: game.widget,
      ),
    );
  }
}
