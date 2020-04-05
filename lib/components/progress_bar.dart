import 'package:flutter/material.dart';
import 'package:monsterjump/utils/Country.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBar extends StatefulWidget {
  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  Future<String> fetchData() async {
    final response = await http.get('https://corona.lmao.ninja/countries');

    if (response.statusCode == 200) {
      final parsedResponse =
          jsonDecode(response.body).cast<Map<String, dynamic>>();

      final list = parsedResponse
          .map<Country>((json) => Country.fromJson(json))
          .toList();
      int i = 0;
      while (i < list.length) {
        var entry = list[i];
        if (entry.name == 'Germany') return entry.todayCases.toString();
        i++;
      }
      return ' ';
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<String> fetchGamesCount() async {
    return Firestore.instance
        .collection('stats')
        .document('stat')
        .get()
        .then((docSnap) => docSnap != null ? docSnap.data['gamesCount'] : null)
        .then((games) {
      print("fetchGamesCount(): $games");
      return games.toString();
    });
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
                      color: Colors.white,
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
                        FutureBuilder<String>(
                          future: fetchGamesCount(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? Text(snapshot.data.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Impact',
                                      fontSize: 21,
                                      color: Colors.white,
                                    ))
                                : Center(child: CircularProgressIndicator());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                          child: Text('Spiele insg.',
                              style: TextStyle(
                                fontFamily: 'Impact',
                                fontSize: 11,
                                color: Colors.white,
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
                        FutureBuilder<String>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? Text(snapshot.data.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Impact',
                                      fontSize: 21,
                                      color: Colors.white,
                                    ))
                                : Center(child: CircularProgressIndicator());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                          child: Text('*neue Fälle in DE',
                              style: TextStyle(
                                fontFamily: 'Impact',
                                fontSize: 11,
                                color: Colors.white,
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
                  percent: 0,
                  progressColor: Color(0xFF40DBFF),
                  backgroundColor: Color(0xFFE1F5FE),
                  animationDuration: 2000,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    "0%",
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
                child: Text(
                  '*data worldometers.info/coronavirus',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
