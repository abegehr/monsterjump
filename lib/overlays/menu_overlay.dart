import 'package:flutter/material.dart';

class MenuOverlay extends StatelessWidget {
  final Function start;

  MenuOverlay({Key key, this.start}) : super(key: key);

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
        Positioned(
          top: 180,
          left: 10,
          child: Container(
            width: 280,
            height: 150,
            child: Image.asset(
              'assets/images/ui/title.png',
            ),
          ),
        ),
        Container(
            width: 165,
            height: 50,
            child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: FlatButton(
                    onPressed: start,
                    padding: EdgeInsets.all(0.0),
                    child: Image.asset(
                      'assets/images/ui/play-button.png',
                    )))),
        Positioned(
          bottom: 32,
          right: 32,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.white,
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
