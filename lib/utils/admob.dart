import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

class Admob {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['game', 'corona', 'awesome', 'fun'],
    contentUrl: 'https://coronajump.app',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  static BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: getBannerAdUnitId(),
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
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

    // load ad units
    myBanner.load();
  }

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

  static void showBannerAdUnit() {
    myBanner.show(
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
      anchorType: AnchorType.bottom,
    );
  }

  static void removeBannerAdUnit() {
    myBanner.dispose();
  }
}
