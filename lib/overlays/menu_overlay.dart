import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        Positioned(
          top: 275,
          left: 30,
          child: Container(
            width: 280,
            height: 150,
            child: Image.asset(
              'assets/images/ui/stayathomeandplaycoronajump.png',
            ),
          ),
        ),
        Center(
          child: Container(
              width: 165,
              height: 50,
              child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: FlatButton(
                      onPressed: start,
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset(
                        'assets/images/ui/play_button.png',
                      )))),
        ),
        Positioned(
          bottom: 32,
          right: 32,
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
      ],
    );
  }
}

_launchURL() async {
  const url = 'https://places.rocks/coronajump-dse';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
