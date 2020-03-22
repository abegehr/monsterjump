import 'package:flutter/foundation.dart';

class Globals {
  // max screen width
  static double maxGameWidth = 420.0;

  // Box2D pixels to meters
  static double ptm = 0.05;
  static double mtp = 1 / ptm;

  // jump
  static double jumpVY = 20.0;

  // Box2D debug rendering
  static bool renderBox2DShapes = !kReleaseMode;
}
