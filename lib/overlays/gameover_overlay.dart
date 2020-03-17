import 'package:flutter/material.dart';

class GameoverOverlay extends StatelessWidget {
  final Function start;

  GameoverOverlay({Key key, this.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 240,
            height: 240,
            color: Color(0x88FF0000),
            child: Column(children: <Widget>[
              Text("GAME OVER"),
              FlatButton(
                onPressed: start,
                child: Text("Start New Game"),
              )
            ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
