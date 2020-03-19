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
          Text('Personal HighScore: 5342'),
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
