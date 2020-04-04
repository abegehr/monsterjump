import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as Math;

class Score {
  static Future<String> getUUID() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

    String uuid;
    try {
      if (!kIsWeb) {
        if (Platform.isAndroid) {
          // Android
          var build = await deviceInfoPlugin.androidInfo;
          uuid = build.androidId; //UUID for Android
        } else if (Platform.isIOS) {
          // iOS
          var data = await deviceInfoPlugin.iosInfo;
          uuid = data.identifierForVendor; //UUID for iOS
        }
      } else {
        // web
        //TODO generate unique ID for web.
      }
    } on Exception {
      print('Failed to get UUID');
    }

    print("getUUID(): $uuid");
    return uuid;
  }

  static incrementGamesCounter() async {
    try {
      // Update games counter
      const numShards = 10;
      var shardId = (Math.Random().nextInt(numShards)).toString();
      await Firestore.instance
          .collection('stats')
          .document('stat')
          .collection('_counter_shards_')
          .document(shardId)
          .setData({"gamesCount": FieldValue.increment(1)});
    } catch (e) {
      print("incrementGamesCounter error: " + e.toString());
    }
  }

  static saveScore(int score) async {
    String uuid = await getUUID();

    incrementGamesCounter();

    if (uuid != null)
      return Firestore.instance
          .collection('devices')
          .document(uuid)
          .collection('scores')
          .add({
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((docRef) {
        print("saveScore($score): $docRef");
        return docRef;
      });
  }

  static Future<int> getHighscore() async {
    String uuid = await getUUID();
    if (uuid != null)
      return Firestore.instance
          .collection('devices')
          .document(uuid)
          .collection('scores')
          .orderBy('score', descending: true)
          .limit(1)
          .getDocuments()
          .then((querySnap) => querySnap.documents.length >= 1
              ? querySnap.documents.first
              : null)
          .then((docSnap) => docSnap != null ? docSnap.data['score'] : null)
          .then((score) {
        print("getHighscore(): $score");
        return score;
      });
    return null;
  }
}
