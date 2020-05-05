import 'package:flutter/foundation.dart';
import 'package:monsterjump/utils/score.dart';
import 'package:monsterjump/overlays/widgets/share_button.dart';
import 'package:monsterjump/components/progress_bar.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:math';

class GameoverOverlay extends StatelessWidget {
  final Function restart;
  final Function goHome;
  final int score;
  final int localHighScore;

  GameoverOverlay(
      {Key key, this.restart, this.goHome, this.score, this.localHighScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3)),
      child: Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: GestureDetector(
                    onTap: goHome,
                    child: Image.asset(
                      'assets/images/ui/menu_button.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image.asset('assets/images/ui/game_over.png'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10), child: new RandomImage()),
            ),

            // RestartButton
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: restart,
                child: Image.asset(
                  'assets/images/ui/try_again.png',
                  width: 197,
                  height: 50,
                ),
              ),
            ),
            Expanded(flex: 3, child: ProgressBar()),

            // ShareButton
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    //Score
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Your Score: $score',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Impact',
                                color: Colors.white,
                              )),
                          FutureBuilder(
                              future: Score.getHighscore(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<int> snap) {
                                String text = "";
                                int score = snap.data;
                                if (kIsWeb)
                                  text = "Personal HighScore: " +
                                      localHighScore.toString();
                                else if (snap.hasData)
                                  text = score != null
                                      ? "Personal HighScore: $score"
                                      : "Personal HighScore: loading…";
                                else if (snap.hasError)
                                  text = "Failed loading Highscore";
                                return Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Impact',
                                    color: Colors.white,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    ShareButton(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () {
                    js.context.callMethod(
                        "open", ["https://www.instagram.com/coronajumpcom/"]);
                  },
                  child: Image.asset(
                    'assets/images/cj/instagram.png',
                  )),
            ),
            // HomeButton
          ],
        ),
      ),
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
    int randomNumber = random.nextInt(5) + 1;
    return Container(
        width: 130,
        child: Image.asset('assets/images/tipps/$randomNumber.png'));
  }
}
