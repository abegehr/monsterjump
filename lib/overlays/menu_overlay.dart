import 'package:coronajump/overlays/widgets/share_button.dart';
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
        Center(
          child: RaisedButton(
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
        Positioned(bottom: 128, right: 32, child: ShareButton()),
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
