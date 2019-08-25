import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_wetterwolke/data/backend.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:http/src/response.dart' as http;

class StatisticsModel extends ChangeNotifier {
  final String locationId;
  Statistics statistics;

  StatisticsModel(this.locationId);

  void fetch() {
    fetchStats({locationId}).then((response) {
      processStatistics(response);
    });
  }

  void processStatistics(http.Response response) {
    readStats(response.body);
  }

  void readStats(String jsonString) {
    var json = jsonDecode(jsonString);
    if (json.length > 0) {
      statistics = Statistics.fromJson(json[0]);
      notifyListeners();
    }
  }
}

class Statistics {
  final String id;
  final List<StatisticsSet> range;

  Statistics(this.id, this.range);

  Statistics.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        range = convertRangeFromJson(json['stats']);
  
  bool containsSolarInformation() {
    var statisticSetWithSolar = range.firstWhere((statisticSet) => statisticSet.containsSolarInformation(), orElse: () => null);
    return statisticSetWithSolar != null;
  }
}

List<StatisticsSet> convertRangeFromJson(List<dynamic> jsonSets) {
  List<StatisticsSet> range = [];
  for (var json in jsonSets) {
    range.add(StatisticsSet.fromJson(json));
  }
  return range;
}

class StatisticsSet {
  final String range;
  final num maxTemperature;
  final num minTemperature;
  final num rain;
  final num solarRadiationMax;
  final num kwh;

  StatisticsSet(this.range, this.maxTemperature, this.minTemperature, this.rain,
      this.solarRadiationMax, this.kwh);

  StatisticsSet.fromJson(Map<String, dynamic> json)
      : range = json["range"],
        maxTemperature = json["maxTemperature"],
        minTemperature = json["minTemperature"],
        rain = json["rain"],
        solarRadiationMax = json["solarRadiationMax"],
        kwh = json["kwh"];

  Map<String, dynamic> toJson() =>
      {
        'range': range,
        'maxTemperature': maxTemperature,
        'minTemperature': minTemperature,
        'rain': rain,
        'solarRadiationMax': solarRadiationMax,
        'kwh': kwh
      };

  bool containsSolarInformation() {
    return solarRadiationMax != null || kwh != null;
  }

}

List<String> formatStatisticsSet(StatisticsSet stats) {
  List<String> formatted = [];
  formatted.add(mapRange(stats.range));
  formatted.add(format(stats.rain, postfix: "l"));
  formatted.add(format(stats.minTemperature, postfix: "°C"));
  formatted.add(format(stats.maxTemperature, postfix: "°C"));
  formatted.add(format(stats.kwh, postfix: "kWh"));
  formatted.add(format(stats.solarRadiationMax, postfix: "W/m²"));
  return formatted;
}

String mapRange(String range) {
  if (range == "today") {
    return "Heute";
  } else if (range == "yesterday") {
    return "Gestern";
  } else if ( range == "last7days") {
    return "7 Tage";
  } else if (range == "last30days") {
    return "30 Tage";
  } else {
    return "";
  }
}
