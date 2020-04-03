import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

class LandingPage extends StatelessWidget {
  final Function goHome;
  LandingPage({Key key, this.goHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -180,
          right: -200,
          width: 512,
          height: 512,
          child: Image.asset(
            'assets/images/virus/virus.png',
          ),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 180),
            // Title
            Align(
              alignment: Alignment(-1.0, 1.0),
              child: Image.asset(
                'assets/images/ui/title.png',
                width: 280,
                height: 150,
              ),
            ),
            Align(alignment: Alignment(-0.8, 0.0), child: new RandomImage()),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Impact',
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                      text:
                          "Die Idee ist aus dem #WirVsVirus Hackathon entstanden, für den sich über 40k Teilnehmer (nur in DE) registriert haben. Viele davon, so wie wir, haben sich für die vielen Challanges der Corona Krise eine Lösung in Form einer App ausgedacht. Das Problem allerdings: Apple und Google gestatten keine Apps zum Thema 'COVID-19' in ihren Stores, die nicht von einer Gesundheitsorganisation o.Ä. "),
                  TextSpan(text: "veröffentlicht werden "),
                ])),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Impact',
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                      text:
                          "Die Idee ist aus dem #WirVsVirus Hackathon entstanden, für den sich über 40k Teilnehmer (nur in DE) registriert haben. Viele davon, so wie wir, haben sich für die vielen Challanges der Corona Krise eine Lösung in Form einer App ausgedacht. Das Problem allerdings: Apple und Google gestatten keine Apps zum Thema 'COVID-19' in ihren Stores, die nicht von einer Gesundheitsorganisation o.Ä. "),
                  TextSpan(text: "veröffentlicht werden "),
                ])),
            // PlayButton;
            GestureDetector(
              onTap: goHome,
              child: Image.asset(
                'assets/images/ui/play_button.png',
                width: 210,
                height: 60,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RandomImage extends StatefulWidget {
  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  @override
  Widget build(BuildContext content) {
    Random random = new Random();
    int randomNumber = random.nextInt(4) + 1;
    return Container(
        width: 280,
        child: Image.asset('assets/images/subtitle/$randomNumber.png'));
  }
}
