import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:coronajump/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

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
