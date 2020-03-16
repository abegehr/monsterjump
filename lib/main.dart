import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:coronajump/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.images.loadAll(<String>[
    'bg/background.png',
    'bg/lose-splash.png',
    'virus/virus.png',
    'platform/platform.png',
    'branding/title.png',
    'ui/start-button.png',
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  CoronaJump game = CoronaJump();
  runApp(game.widget);
}
