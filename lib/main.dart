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
  runApp(new MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GameContainer createState() => GameContainer();
}

class GameContainer extends State<MyHomePage> {
  final CoronaJump game = CoronaJump();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 300,
              child: KeyboardListener(),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 420),
              child: game.widget,
            )
          ],
        ),
      ),
    );
  }
}

class KeyboardListener extends StatefulWidget {
  KeyboardListener();

  @override
  _RawKeyboardListenerState createState() => new _RawKeyboardListenerState();
}

class _RawKeyboardListenerState extends State<KeyboardListener> {
  TextEditingController _controller = new TextEditingController();
  FocusNode _textNode = new FocusNode();

  @override
  initState() {
    super.initState();
  }

  handleKey(RawKeyEventDataAndroid key) {
    print('KeyCode: ${key.keyCode}, CodePoint: ${key.codePoint}, '
        'Flags: ${key.flags}, MetaState: ${key.metaState}, '
        'ScanCode: ${key.scanCode}');
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _textNode,
      onKey: (key) => handleKey(key.data),
      child: TextField(
        controller: _controller,
        focusNode: _textNode,
      ),
    );
  }
}
