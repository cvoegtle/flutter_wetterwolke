class Statistics {
  final String id;
  final List<StatisticsSet> range;

  Statistics(this.id, this.range);

  Statistics.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        range = convertRangeFromJson(json['stats']);
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

  Map<String, dynamic> toJson() => {
        'range': range,
        'maxTemperature': maxTemperature,
        'minTemperature': minTemperature,
        'rain': rain,
        'solarRadiationMax': solarRadiationMax,
        'kwh': kwh
      };
}
