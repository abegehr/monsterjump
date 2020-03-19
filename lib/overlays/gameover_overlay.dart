import 'package:coronajump/utils/score.dart';
import 'package:flutter/material.dart';

class GameoverOverlay extends StatelessWidget {
  final Function start;
  final int score;

  GameoverOverlay({Key key, this.start, this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 200, child: Image.asset('assets/images/ui/game_over.png')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Your Score: $score'),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: RaisedButton(
                  onPressed: start,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  color: Colors.blue[500]),
            ),
          ),
        ],
      ),
    );
  }
}
