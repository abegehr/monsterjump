import 'package:flutter/material.dart';
import 'package:share/share.dart';

Future<void> share() => Share.share(
    'Check out this cool game https://example.com and stay at home!');

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: share,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Share with Friends',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.blue[500],
            ),
          ),
        ),
        color: Colors.white);
  }
}
