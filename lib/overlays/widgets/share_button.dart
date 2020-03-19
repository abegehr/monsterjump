import 'package:flutter/material.dart';
import 'package:share/share.dart';

Future<void> share() => Share.share(
    'Check out this cool game: https://coronajump.page.link/download and stay at home!');

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 165,
          height: 50,
          child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: FlatButton(
                  onPressed: share,
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    'assets/images/ui/share_button.png',
                  )))),
    );
  }
}
