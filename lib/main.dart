import 'package:flame/flame.dart';
import 'package:coronajump/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';

void main() {
  Flame.images.loadAll(<String>['bg/background.png', 'virus/virus.png']);

  CoronaJump game = CoronaJump();
  runApp(game.widget);

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
