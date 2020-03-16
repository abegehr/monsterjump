import 'package:flutter/material.dart';

class MenuOverlay extends StatelessWidget {
  final Function start;

  MenuOverlay({Key key, this.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 240,
            height: 240,
            color: Color(0x88FF0000),
            child: Column(children: <Widget>[
              Text("CoronaJump"),
              FlatButton(
                onPressed: start,
                child: Text("Start Game"),
              )
            ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
