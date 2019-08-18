import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';

var testStats =
    '[{"stats":[{"rain":0.295,"range":"lastHour"},{"maxTemperature":17.527275,"rain":0.59,"minTemperature":9.58,"range":"today"},{"maxTemperature":19.589998,"minTemperature":11.254546,"range":"yesterday"},{"maxTemperature":27.911112,"rain":12.9800005,"minTemperature":8.099999,"range":"last7days"},{"maxTemperature":36.3,"rain":31.86,"minTemperature":8.099999,"range":"last30days"}],"id":"tegelweg8"},{"stats":[{"rain":0.19999999,"range":"lastHour"},{"maxTemperature":16.999998,"rain":0.39999998,"minTemperature":10.419999,"solarRadiationMax":1134,"range":"today","kwh":2.1887038},{"maxTemperature":19.139997,"minTemperature":11.806668,"solarRadiationMax":919,"range":"yesterday","kwh":3.0964687},{"maxTemperature":27.253334,"rain":9.599999,"minTemperature":8.900001,"solarRadiationMax":1144,"range":"last7days","kwh":35.67035},{"maxTemperature":35.700005,"rain":23.8,"minTemperature":8.900001,"solarRadiationMax":1162,"range":"last30days","kwh":147.10402}],"id":"wetterwolke"}]';

void main() {
  test('JSON serialisierung / deserialisierung StatisticsSet', () {
    var stats = StatisticsSet("yesterday", 22.2, 11.1, 9.2, 1119, 4.1);
    var json = stats.toJson();
    var deserialized = StatisticsSet.fromJson(json);
    expect(stats.range, deserialized.range);
    expect(stats.maxTemperature, deserialized.maxTemperature);
    expect(stats.minTemperature, deserialized.minTemperature);
    expect(stats.rain, deserialized.rain);
    expect(stats.solarRadiationMax, deserialized.solarRadiationMax);
    expect(stats.kwh, deserialized.kwh);
  });

  test('JSON deserialisierung Stats', () {
    var json = jsonDecode(testStats);
    List<Statistics> statistics = [];
    for (var statisticsJson in json) {
      statistics.add(Statistics.fromJson(statisticsJson));
    }
    statistics.length;
  });
}
