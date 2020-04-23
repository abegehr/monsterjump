import 'package:flutter/foundation.dart';
import 'package:monsterjump/overlays/widgets/share_button.dart';
import 'package:monsterjump/utils/score.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:monsterjump/components/progress_bar.dart';
import 'dart:math';

class MenuOverlay extends StatelessWidget {
  final Function start;
  final int localHighScore;

  MenuOverlay({Key key, this.start, this.localHighScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -180,
          right: -200,
          width: 500,
          height: 500,
          child: Image.asset(
            'assets/images/virus/virus.png',
          ),
        ),
        Column(
          children: <Widget>[
            // Title
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment(-0.80, 0.5),
                child: Image.asset(
                  'assets/images/ui/title.png',
                  width: 280,
                  height: 150,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment(-0.8, 0.0), child: new RandomImage())),
            // PlayButton
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: start,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
            ),
            // ShareButton
            Expanded(
              flex: 1,
              child: ShareButton(),
            ),
            // Highscore
            FutureBuilder(
                future: Score.getHighscore(),
                builder: (BuildContext context, AsyncSnapshot<int> snap) {
                  String text = "";
                  int score = snap.data;
                  if (kIsWeb)
                    text = "Personal HighScore: " + localHighScore.toString();
                  else if (snap.hasData)
                    text = score != null
                        ? "Personal HighScore: $score"
                        : "Personal HighScore: loading…";
                  else if (snap.hasError) text = "Failed loading Highscore";
                  return Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  );
                }),
            // PrivacyPolicyButton
            Expanded(
              flex: 2,
              child: ProgressBar(),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: _launchURL,
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RandomImage extends StatefulWidget {
  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  @override
  Widget build(BuildContext content) {
    Random random = new Random();
    int randomNumber = random.nextInt(4) + 1;
    return Container(
        width: 280,
        child: Image.asset('assets/images/subtitle/$randomNumber.png'));
  }
}

_launchURL() async {
  const url = 'https://places.rocks/monsterjump-dse';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
