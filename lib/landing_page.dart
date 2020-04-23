import 'dart:ui';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:monsterjump/components/progress_bar.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              // Random Image
              Align(alignment: Alignment(-0.8, 0.0), child: new RandomImage()),
              SizedBox(height: 80),
              // PlayButton
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 110),
              // Content "Corona jump"
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
                  ' Wir wollen Corona Jump zum Symbol gegen alle Arten von Corona Partys machen. Wenn Andere zuhause bleiben müssen und dieses * Spiel spielen, kannst du das auch.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  )),
              SizedBox(height: 80),
              Text('Fortschritt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              ProgressBar(),

              SizedBox(height: 80),
              // Content "Unser Ziel"
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
                  ' Wir teilen die Anzahl aller Spiele durch die tägliche Anzahl an neuen Infizierten in Deutschland, um den Fortschritt festzuhalten.  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    color: Colors.white,
                  )),
              Text(
                  ' Dein persönlicher Highscore soll künftig auch berücksichtigt werden.  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),
// Content "Unser Beitrag"
              Text('Unser Beitrag:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Uns ist natürlich bewusst, dass dieses Spiel das Problem Corona und die damit verbundene Pandemie nicht lösen kann. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Text(
                  ' Dennoch möchten wir einen kleinen symbolischen Beitrag leisten, um die Ausbreitung einzudämmen und vor allem unsere Generation an ihre Verantwortung gegenüber den Schwächeren und Älteren zu erinnern. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 110),
              // Gameplay Image
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/cj/game_play.png',
                  width: 375,
                ),
              ),
              SizedBox(height: 110),
              // Content "Warum nicht als App"
              Text('Corona Jump als App?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Impact',
                    color: Colors.white,
                  )),

              SizedBox(height: 30),
              Text(
                  ' Apple und Google gestatten keine Apps mit Bezug zu “COVID-19” in ihren Stores, es sei denn sie sind von einer offiziellen Gesundheitsorganisation (mehr weiter unten). Deshalb haben wir einmal Corona Jump als Web-App und einmal "Monster Jump". ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  js.context.callMethod("open", [
                    "https://play.google.com/store/apps/details?id=app.monsterjump.app"
                  ]);
                },
                child: Image.asset(
                  'assets/images/ui/playstore.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  js.context.callMethod("open", [
                    "https://apps.apple.com/us/app/monsterjump-go-high/id1502870226?l=de&ls=1"
                  ]);
                },
                child: Image.asset(
                  'assets/images/ui/appstore.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 80),
              // Content "Wie kann ich unterstützen?"
              Text('Wie kann ich mitmachen?',
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

              // Play Button #2
              GestureDetector(
                onTap: goHome,
                child: Image.asset(
                  'assets/images/ui/play_button.png',
                  width: 210,
                  height: 60,
                ),
              ),
              SizedBox(height: 110),
              // Content "Über uns"
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
              // Contact
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
              // Impressum link
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.white10,
                  onPressed: () {
                    js.context
                        .callMethod("open", ["https://places.rocks/impressum"]);
                  },
                  child: Text(
                    'Impressum',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // DSE link
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.white10,
                  onPressed: () {
                    js.context.callMethod(
                        "open", ["https://places.rocks/monsterjump-dse"]);
                  },
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
              // Footer
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
