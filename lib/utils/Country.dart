import 'dart:convert';

class Country {
  // {"country":"China","cases":80849,"todayCases":25,"deaths":3199,"todayDeaths":10,"recovered":66915,"critical":3226}
  final String name;
  final int cases;
  /*final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int critical;*/

  Country({
    this.name,
    this.cases,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['country'],
      cases: json['cases'],
    );
  }

  Map<String, dynamic> toJson() => {
        'country': name,
        'cases': cases,
      };

  @override
  String toString() => json.encode(toJson());
}
