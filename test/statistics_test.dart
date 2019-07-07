import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/statistics.dart';

void main() {
  test('JSON serialisierung / deserialisierung', () {
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
}

