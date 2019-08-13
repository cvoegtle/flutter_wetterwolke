import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wetterwolke/backend.dart';
import 'package:flutter_wetterwolke/configuration.dart';
import 'package:flutter_wetterwolke/locationcalculator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherDataModel extends ChangeNotifier {
  Set<String> locations = Set();
  Configuration configuration = Configuration([], []);
  final List<WeatherData> _dataSets = [];

  UnmodifiableListView<WeatherData> get dataSets =>
      UnmodifiableListView(_dataSets);
  LocationProvider locationProvider = LocationProvider();

  void init() {
    fetchConfiguration().then((response) {
      processConfiguration(response);
    });
  }

  void fetch() {
    locationProvider.fetch();
    fetchData(locations).then((response) => processWeatherData(response));
  }

  void processWeatherData(http.Response response) {
    List<WeatherData> receivedLocations = readWeatherData(response);
    if (receivedLocations.length > 0) {
      locationProvider.calculateDistances(receivedLocations);
      _dataSets.clear();
      _dataSets.addAll(receivedLocations);
      notifyListeners();
    }
  }

  processConfiguration(http.Response response) {
    var body = Utf8Decoder().convert(response.bodyBytes);
    configuration = readConfiguration(body);
    SharedPreferences.getInstance()
        .then((prefs) => addLocalConfiguration(prefs));
  }

  addLocalConfiguration(SharedPreferences prefs) {
    configuration.locations.forEach((location) {
      location.enabled = prefs.getBool(location.location) == true;
      if (location.enabled) {
        locations.add(location.location);
      }
    });
    
    fetch();
  }

  void reinitialize() {
    locations = Set();
    SharedPreferences.getInstance()
        .then((prefs) => addLocalConfiguration(prefs));
  }
}

readWeatherData(http.Response response) {
  List<WeatherData> parsedWeatherData = [];

  List json = jsonDecode(response.body);
  json.forEach((j) => parsedWeatherData.add(WeatherData.fromJson(j)));

  return parsedWeatherData;
}

class WeatherData {
  final String id;
  final String timestamp;
  final String localtime;
  final String location;
  final String locationShort;
  final num latitude;
  final num longitude;
  final num temperature;
  final num humidity;
  final num barometer;
  final int solarradiation;
  final num UV;
  final num rain;
  final num rainToday;
  final bool raining;
  final String forecast;
  double distance;

  WeatherData(
      this.id,
      this.timestamp,
      this.localtime,
      this.location,
      this.locationShort,
      this.latitude,
      this.longitude,
      this.temperature,
      this.humidity,
      this.barometer,
      this.solarradiation,
      this.UV,
      this.rain,
      this.rainToday,
      this.raining,
      this.forecast);

  WeatherData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        timestamp = json['timestamp'],
        localtime = json['localtime'],
        location = json['location'],
        locationShort = json['location_short'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        temperature = json['temperature'],
        humidity = json['humidity'],
        barometer = json['barometer'],
        solarradiation = json['solarradiation'],
        UV = json['UV'],
        rain = json['rain'],
        rainToday = json['rain_today'],
        raining = json['raining'],
        forecast = json['forecast'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': timestamp,
        'localtime': localtime,
        'location': location,
        'location_short': locationShort,
        'latitude': latitude,
        'longitude': longitude,
        'temperature': temperature,
        'humidity': humidity,
        'barometer': barometer,
        'solarradiation': solarradiation,
        'UV': UV,
        'rain': rain,
        'rain_today': rainToday,
        'raining': raining,
        'forecast': forecast,
      };
}
