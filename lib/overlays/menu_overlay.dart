import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MenuOverlay extends StatelessWidget {
  final Function start;
  Future<void> share() {
    return Share.share(
        'Check out this cool game https://example.com and stay at home!');
  }

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
        Center(
          child: FlatButton(
              onPressed: start,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'PLAY',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.blue[500]),
        ),
        Positioned(
          bottom: 165,
          right: 50,
          child: Center(
            child: Container(
                width: 165,
                height: 50,
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(
                        onPressed: start,
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset(
                          'assets/images/ui/share_button.png',
                        )))),
          ),
        ),
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
