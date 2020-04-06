import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  void onPress(TapUpDetails e) {
    print("ShareButton – pressed: ${e.globalPosition}");
    Share.share(
      'Check out this cool game: https://monsterjump.page.link/download and stay at home!',
      sharePositionOrigin:
          Rect.fromCenter(center: e.globalPosition, width: 100, height: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTapUp: onPress,
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
