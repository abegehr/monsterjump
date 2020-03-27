import 'package:monsterjump/utils/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:monsterjump/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                        SizedBox(
              width: double.infinity,
              height: 300,
              child: KeyboardListener(),
            ),
            Container(constraints: BoxConstraints(maxWidth: 420), child: game.widget,)
          ],
        ),
      );
  }
}
