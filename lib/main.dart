import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:coronajump/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['game', 'corona', 'awesome', 'fun'],
    contentUrl: 'https://places.rocks',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  myBanner
    // typically this happens well before the ad is shown
    ..load()
    ..show(
      // Positions the banner ad 60 pixels from the bottom of the screen
      anchorOffset: 0.0,
      // Positions the banner ad 10 pixels from the center of the screen to the right
      horizontalCenterOffset: 0.0,
      // Banner Position
      anchorType: AnchorType.bottom,
    );

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
