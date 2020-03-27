import 'package:flutter/material.dart';
import 'package:share/share.dart';

Future<void> share() => Share.share(
    'Check out this cool game: https://monsterjump.page.link/download and stay at home!');

class ShareButton extends StatelessWidget {
  void onPress() {
    print("ShareButton – pressed");
    share();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: onPress,
          child: Image.asset(
            'assets/images/ui/share_button.png',
            width: 165,
            height: 50,
          ),
        ),
      ),
    );
  }
}
