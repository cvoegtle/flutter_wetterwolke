// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/data/backend.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:http/src/response.dart';

void main() {
  test('weatherdata serialisation', () {
    var data = WeatherData(
        'wetterwolke',
        'Mon Jun 24 13:21:00 UTC 2019',
        '15:21',
        'Paderborn 2.0',
        'PB2',
        51.723778,
        8.756154,
        29.8,
        43,
        1019.032,
        722,
        4.8,
        null,
        null,
        false,
        'http://wetterstationen.meteomedia.de/?station=104300&wahl=vorhersage');
    var json = data.toJson();
    expect(json['id'], data.id);
    expect(json['barometer'], data.barometer);
    expect(json['unbekannt'], null);
  });

  test('weatherdata deserialisation', () {
    var weatherDataAsString =
        '{"localtime":"16:38","UV":2,"latitude":51.723717,"barometer":1018.558,"raining":false,"forecast":"http://wetterstationen.meteomedia.de/?station=104300&wahl=vorhersage","solarradiation":98,"location_short":"PB2","temperature":29.9,"humidity":43,"location":"Paderborn 2.0","id":"wetterwolke","timestamp":"Mon Jun 24 14:38:00 UTC 2019","wind":3.2,"longitude":8.756154}';
    var json = jsonDecode(weatherDataAsString);
    var weatherData = WeatherData.fromJson(json);
    expect(51.723717, weatherData.latitude);
    expect('16:38', weatherData.localtime);
    expect(
        'http://wetterstationen.meteomedia.de/?station=104300&wahl=vorhersage',
        weatherData.forecast);
    expect(1018.558, weatherData.barometer);
  });

  test('fetch weatherdata from wettercentral', () {
    Set<String> singleLocation = Set();
    singleLocation.add('tegelweg8');
    var future = fetchData(singleLocation);
    expect(true, future != null);
    future.then(expectAsync1((Response response) {
      expect(200, response.statusCode);
      var weatherData = readWeatherData(response);
      expect("tegelweg8", weatherData[0].id);
      expect("PB", weatherData[0].locationShort);
    }));
  });

  test('fetch weatherdata from multiple locations', () {
    Set<String> multipleLocations = Set.from([
      'tegelweg8',
      'bali',
      'forstweg17',
      'ochsengasse',
      'leoxity'
    ]);
    var future = fetchData(multipleLocations);
    expect(true, future != null);
    future.then(expectAsync1((Response response) {
      expect(200, response.statusCode);
      List<WeatherData> weatherData = readWeatherData(response);
      expect(5, weatherData.length);
      expect("tegelweg8", weatherData[0].id);
      expect("PB", weatherData[0].locationShort);
      expect("Leo", weatherData[4].locationShort);
    }));
  });

  test('Set to String', () {
    Set<String> strings = Set();
    strings.add('hallo');
    strings.add('Du');
    strings.add('da');
    expect('hallo,Du,da', setToString(strings, ","));
  });
}

checkResponse(Response response) {
  print("Status Code: ${response.statusCode}\nbody: ${response.body}");
}

checkError(error) {
  print(error);
}
