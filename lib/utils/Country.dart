import 'dart:convert';

class Country {
  // {"country":"China","cases":80849,"todayCases":25,"deaths":3199,"todayDeaths":10,"recovered":66915,"critical":3226}
  final String name;
  final int todayCases;
  /*final int cases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int critical;*/

  Country({
    this.name,
    this.todayCases,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['country'],
      todayCases: json['todayCases'],
    );
  }

  Map<String, dynamic> toJson() => {
        'country': name,
        'todayCases': todayCases,
      };

  @override
  String toString() => json.encode(toJson());
}
