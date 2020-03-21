import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

class Admob {
  static BannerAd _bannerAd;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'game',
      'corona',
      'fun',
      'virus',
      'health',
      'home',
      'safe'
    ], // TODO get keywords from Firebase Remoteconfig
    contentUrl: 'https://coronajump.app',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  static bool shouldEnable() => Platform.isAndroid || Platform.isIOS;

  static String getAppId() {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-2773918257223246~2092525035';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-2773918257223246~2647892952';
      } else {
        return null;
      }
    } else {
      return FirebaseAdMob.testAppId;
    }
  }

  static void init() {
    if (shouldEnable()) FirebaseAdMob.instance.initialize(appId: getAppId());
  }

  // banner ad

  static String getBannerAdUnitId() {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-2773918257223246/1799282503';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-2773918257223246/6359482225';
      } else {
        return null;
      }
    } else {
      return BannerAd.testAdUnitId;
    }
  }

  static void loadBannerAd() {
    _bannerAd = new BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: getBannerAdUnitId(),
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    )..load();
  }

  static void showBannerAd() {
    _bannerAd?.show(
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
      anchorType: AnchorType.bottom,
    );
  }

  static void removeBannerAd() {
    _bannerAd?.dispose();
  }
}
