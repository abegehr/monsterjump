import 'package:monsterjump/utils/score.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GameoverOverlay extends StatelessWidget {
  final Function restart;
  final Function goHome;
  final int score;

  GameoverOverlay({Key key, this.restart, this.goHome, this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 200, child: Image.asset('assets/images/ui/game_over.png')),
          Padding(padding: const EdgeInsets.all(10), child: new RandomImage()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Your Score: $score',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ),
          FutureBuilder(
              future: Score.getHighscore(),
              builder: (BuildContext context, AsyncSnapshot<int> snap) {
                String text = "";
                int score = snap.data;
                if (snap.hasData)
                  text = score != null
                      ? "Personal HighScore: $score"
                      : "Personal HighScore: loading…";
                else if (snap.hasError) text = "Failed loading Highscore";
                return Text(text);
              }),
          SizedBox(height: 10),
          // RestartButton
          GestureDetector(
            onTap: restart,
            child: Image.asset(
              'assets/images/ui/try_again.png',
              width: 197,
              height: 50,
            ),
          ),
          SizedBox(height: 50),
          // HomeButton
          GestureDetector(
            onTap: goHome,
            child: Image.asset(
              'assets/images/ui/menu_button.png',
              width: 197,
              height: 50,
            ),
          ),
        ],
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
        width: 180,
        child: Image.asset('assets/images/tipps/$randomNumber.png'));
  }
}
