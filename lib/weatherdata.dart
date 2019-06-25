import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class WeatherDataModel extends ChangeNotifier {
  final Set<String> locations = Set.from(['wetterwolke', 'tegelweg8', 'bali', 'leoxity', 'elb', 'herzo','ochsengasse', 'shenzhen']);
  final List<WeatherData> _dataSets = [];

  UnmodifiableListView<WeatherData> get dataSets => UnmodifiableListView(_dataSets);

  void fetch() {
    fetchWeatherData(locations).then((response) => processWeatherData(response));
  }

  void processWeatherData(http.Response response) {
    List<WeatherData> receivedLocations = readWeatherData(response);
    if (receivedLocations.length > 0) {
      _dataSets.clear();
      _dataSets.addAll(receivedLocations);
      notifyListeners();
    }
  }

}

readWeatherData(http.Response response) {
  List<WeatherData> parsedWeatherData = [];

  List json = jsonDecode(response.body);
  json.forEach((j) => parsedWeatherData.add(WeatherData.fromJson(j)));

  return parsedWeatherData;
}

Future<http.Response> fetchWeatherData(Set<String> locations) {
  return http.get('https://wettercentral.appspot.com//weatherstation/read?build=786&locations=' + setToString(locations, ','));
}

String setToString(Set<String> set, String separator) {
  var str = "";
  set.forEach((item) => str += item + separator);
  return str.substring(0, str.length -1);
}


class WeatherData {
  final String id;
  final String timestamp;
  final String localtime;
  final String location;
  final String location_short;
  final num latitude;
  final num longitude;
  final num temperature;
  final num humidity;
  final num barometer;
  final int solarradiation;
  final num UV;
  final num rain;
  final num rain_today;
  final bool raining;
  final String forecast;

  WeatherData(
      this.id,
      this.timestamp,
      this.localtime,
      this.location,
      this.location_short,
      this.latitude,
      this.longitude,
      this.temperature,
      this.humidity,
      this.barometer,
      this.solarradiation,
      this.UV,
      this.rain,
      this.rain_today,
      this.raining,
      this.forecast);

  WeatherData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        timestamp = json['timestamp'],
        localtime = json['localtime'],
        location = json['location'],
        location_short = json['location_short'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        temperature = json['temperature'],
        humidity = json['humidity'],
        barometer = json['barometer'],
        solarradiation = json['solarradiation'],
        UV = json['UV'],
        rain = json['rain'],
        rain_today = json['rain_today'],
        raining = json['raining'],
        forecast = json['forecast'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'timestamp': timestamp,
        'localtime': localtime,
        'location': location,
        'location_short': location_short,
        'latitude': latitude,
        'longitude': longitude,
        'temperature': temperature,
        'humidity': humidity,
        'barometer': barometer,
        'solarradiation': solarradiation,
        'UV': UV,
        'rain': rain,
        'rain_today': rain_today,
        'raining': raining,
        'forecast': forecast,
      };
}
