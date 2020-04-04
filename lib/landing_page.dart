import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(height: 180),

              // Title
              Align(
                alignment: Alignment(-0.8, 1.0),
                child: Image.asset(
                  'assets/images/ui/title.png',
                  width: 280,
                  height: 150,
                ),
              ),
              Align(alignment: Alignment(-0.8, 0.0), child: new RandomImage()),
              SizedBox(height: 80),
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 110),
              Text('CORONA JUMP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Text(' -Gemeinsam durch die Krise- ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Wir wollen Corona Jump zum Symbol gegen alle Arten von Corona Partys machen. Wenn Andere zuhause bleiben müssen und dieses ______ Spiel spielen, kannst du das auch.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  )),
              SizedBox(height: 80),
              Container(
                height: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 80),
              Text('Unser Ziel:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Text(
                  ' -Gemeinsam mehr Spiele spielen als Infizierte andere infizieren- ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),
              SizedBox(height: 30),
              Text(
                  ' Jedes Spiel wird zusammengezählt und durch die tägliche Anzahl an neuen Infizierten in Deutschland geteilt, um den Fortschritt festzuhalten.  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    color: Colors.white,
                  )),
              Text(
                  ' Dein persönlicher Highscore soll künftig auch berücksichtigt werden…  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),

              Text('Unser Beitrag:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Uns ist natürlich bewusst, dass dieses Spiel das Problem Corona und die damit verbundene Pandemie nicht lösen kann. Dennoch möchten wir einen kleinen symbolischen Beitrag leisten, um die Ausbreitung einzudämmen und vor allem unsere Generation an ihre Verantwortung gegenüber den Schwächeren und Älteren erinnern.   ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/ui/game_play.png',
                  width: 375,
                ),
              ),
              SizedBox(height: 110),
              Text('Warum nicht als App?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Apple und Google gestatten keine Apps zum Thema “COVID-19” in ihren Stores, es sei denn sie sind von einer offiziellen Gesundheitsorganisation. Mehr weiter unten.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 15),
              Text(
                  ' Außerdem muss man bei einer Web-App wie Corona Jump keine Updates runterladen. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),

              SizedBox(height: 110),
              Text('Corona Jump fürs Handy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 15),
              Text(' Hol dir Corona Jump einfach auf dein Smartphone. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Table(children: [
                TableRow(children: [
                  Text("iOS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  Text("Android",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.asset(
                      'assets/images/ui/ios_share.png',
                      height: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.asset(
                      'assets/images/ui/android_settings.png',
                      height: 32,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Zum Home-Bildschirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Zum Startbildschirm hinzu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Hinzufügen",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Hinzufügen",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )),
                  ),
                ])
              ]),
              SizedBox(height: 110),
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 110),
              Text('Wie kann ich unterstützen?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Bleib am Besten zu Hause und verbessere deinen Highscore. Wenn du noch mehr tun möchtest, teile einen Screenshot in deine Story oder Profil mit dem Hashtag: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 15),
              Text(' #stayathomeandplaycoronajump ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
              SizedBox(height: 15),
              Text(
                  ' Wir haben vor, künftig alle Markierungen auf dieser Seite zu teilen.  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),
              Text('Über uns:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Wir sind 4 Studenten aus Berlin und Nürnberg, die während des Studiums an gemeinsamen Projekten arbeiten.  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              Text(
                  ' Corona Jump wurde zunächst als App im Rahmen des #WirVsVirus Hackathon der deutschen Bundesregierung entwickelt, bis wir die erste Version in den App- & PlayStore einreichen wollten. Ganze 9 Versuche haben wir gebraucht, bis wir auch den letzten Corona-Bezug aus der App entfert hatten und letztendlich geschafft, “Monster Jump” zu veröffentlichen (no joke, check it out - App & PlayStore). ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 15),
              Text(
                  ' Durch Apple und Googles natürliche Monopolstellung erblicken viele kreative Lösungsansätze weltweit, nicht nur aus dem #WirVsVirusHack, nie das Tageslicht... Auch wenn sie gute Gründe dafür haben, kann ein kategorisches Verbot nicht die Lösung sein. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 15),
              Text(
                  ' Btw. die Spiele auf Monster Jump zählen ebenfalls in die Gesamtzahl. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),
              Text('Kontaktiere uns gerne, falls du weitere Fragen hast.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(' info@places.rocks ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 80),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.white10,
                  onPressed: _launchDSE,
                  child: Text(
                    'Impressum',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.white10,
                  onPressed: _launchURL,
                  child: Text(
                    'Datenschutz',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              Text("Places Rocks UG - all rights reserved",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                  )),
              SizedBox(height: 30),
            ],
          ),
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

_launchURL() async {
  const url = 'https://places.rocks/monsterjump-dse';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchDSE() async {
  const url = 'https://places.rocks/impressum';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
