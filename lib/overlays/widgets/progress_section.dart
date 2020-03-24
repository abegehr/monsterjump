import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
