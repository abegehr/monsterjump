import 'package:virusjump/utils/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:virusjump/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Admob.init();
  Admob.loadBannerAd();

  Flame.images.loadAll(<String>[
    'bg/background.png',
    'virus/virus.png',
    'platform/platform.png'
  ]);

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  CoronaJump game = CoronaJump();
  runApp(game.widget);
}
