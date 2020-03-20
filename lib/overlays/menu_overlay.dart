import 'package:coronajump/overlays/widgets/share_button.dart';
import 'package:coronajump/utils/score.dart';
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
        Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment(-1.0, -1.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/ui/title.png',
                        width: 280,
                        height: 150,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/images/ui/stayathomeandplaycoronajump.png',
                          width: 280,
                          height: 150,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: start,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
            ),
            Expanded(flex: 1, child: ShareButton()),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
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
            ),
          ],
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
