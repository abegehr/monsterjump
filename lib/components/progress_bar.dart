import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key key}) : super(key: key);

  @override
  ProgressBarState createState() => ProgressBarState();
}

Future<CoronaCasesGermany> fetchCases() async {
  final response =
      await http.get('https://pomber.github.io/covid19/timeseries.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("fetchcases: " +
        CoronaCasesGermany.fromJson(json.decode(response.body)).toString());
    return CoronaCasesGermany.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class ProgressBarState extends State<ProgressBar> {
  Future<CoronaCasesGermany> futureCCG;

  @override
  void initState() {
    super.initState();
    futureCCG = fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text('Fortschritt =',
                    style: TextStyle(
                      fontFamily: 'Impact',
                      fontSize: 18,
                    )),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('1234',
                            style: TextStyle(
                              fontFamily: 'Impact',
                              fontSize: 21,
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                          child: Text('Spiele insg.',
                              style: TextStyle(
                                fontFamily: 'Impact',
                                fontSize: 11,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                        height: 8,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder<CoronaCasesGermany>(
                          future: futureCCG,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print("DEBUG render data: " +
                                  snapshot.data.confirmed.toString());
                              return Text(snapshot.data.confirmed);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                          child: Text('* reg. Fälle in DE',
                              style: TextStyle(
                                fontFamily: 'Impact',
                                fontSize: 11,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 10.0,
                  animation: true,
                  percent: 0.4,
                  progressColor: Color(0xFF40DBFF),
                  backgroundColor: Color(0xFFE1F5FE),
                  animationDuration: 2000,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    "41,3%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment(1.0, 1.0),
                child: Text('*data worldometer.com (WHO)')), //TODO
          )
        ],
      ),
    );
  }
}

class CoronaCasesGermany {
  final String confirmed;

  CoronaCasesGermany({this.confirmed});

  factory CoronaCasesGermany.fromJson(Map<String, dynamic> json) {
    return CoronaCasesGermany(
      confirmed: json['Germany']['confirmed'],
    );
  }
}
