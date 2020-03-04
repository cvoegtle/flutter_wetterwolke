import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wetterwolke/data/backend.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/configurationkey.dart';
import 'package:flutter_wetterwolke/data/localstorage.dart';
import 'package:flutter_wetterwolke/data/locationcalculator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherDataModel extends ChangeNotifier {
  String _localConfiguration;
  
  Set<String> locations = Set();
  Configuration configuration = Configuration([], []);
  final List<WeatherData> _dataSets = [];
  bool _initialized = false;
  String fetchConfigurationError;

  UnmodifiableListView<WeatherData> get dataSets =>
      UnmodifiableListView(_dataSets);
  LocationProvider locationProvider = LocationProvider();

  void init() {
    fetchLocalConfiguration().then((jsonConfiguration) {
      if (jsonConfiguration != null) {
        processConfigurationString(jsonConfiguration);
        _localConfiguration = jsonConfiguration;
      }
      fetchConfiguration().then((response) {
        processConfiguration(response);
      }, onError: (e) {
        fetchConfigurationError = "onError: " + e.toString();
        notifyListeners();
      }).catchError((e) {
        fetchConfigurationError = "catchError: " + e.toString();
        notifyListeners();
      });
    });
  }

  void fetch() {
    if (_initialized) {
      locationProvider.fetch(proceedWithFetchData);
    }
  }

  void _fetchWitPermissionCheck() {
    locationProvider.fetchWithPermissionCheck(proceedWithFetchData);
  }

  void proceedWithFetchData() {
    fetchData(locations, additional: "&secret=${configuration.secret}")
        .then((response) => processWeatherData(response));
  }

  void processWeatherData(http.Response response) {
    List<WeatherData> receivedLocations = readWeatherData(response);
    if (receivedLocations.length > 0) {
      locationProvider.calculateDistances(receivedLocations);
      _dataSets.clear();
      _dataSets.addAll(receivedLocations);
      _dataSets.sort();
      notifyListeners();
    }
  }

  processConfiguration(http.Response response) {
    String jsonConfiguration = Utf8Decoder().convert(response.bodyBytes);
    if (jsonConfiguration != _localConfiguration) {
      saveConfigurationAsString(jsonConfiguration);
      processConfigurationString(jsonConfiguration);
    }
  }

  void processConfigurationString(String jsonConfiguration) {
    configuration = readConfiguration(jsonConfiguration);
    SharedPreferences.getInstance().then((prefs) {
      addLocalConfiguration(prefs);
    });
  }
  
  addLocalConfiguration(SharedPreferences prefs) {
    ensureInitialConfiguration(prefs, configuration.locations);
    configuration.locations.forEach((location) {
      location.enabled = prefs.getBool(location.location) == true;
      if (location.enabled) {
        locations.add(location.location);
      }
    });
    configuration.secret = prefs.getString(ConfigurationKey.secret);

    _initialized = true;
    _fetchWitPermissionCheck();
  }

  void reinitialize() {
    locations = Set();
    SharedPreferences.getInstance()
        .then((prefs) => addLocalConfiguration(prefs));
  }

  void ensureInitialConfiguration(
      SharedPreferences prefs, List<LocationConfiguration> locations) {
    var first = locations.firstWhere(
        (location) => prefs.getBool(location.location) == true,
        orElse: () => null);
    if (first == null) {
      prefs.setBool("tegelweg8", true);
      prefs.setBool("ochsengasse", true);
      prefs.setBool("forstweg17", true);
      prefs.setBool("herzo", true);
      prefs.setBool("elb", true);
    }
  }
}

readWeatherData(http.Response response) {
  List<WeatherData> parsedWeatherData = [];

  List json = jsonDecode(response.body);
  json.forEach((j) => parsedWeatherData.add(WeatherData.fromJson(j)));

  return parsedWeatherData;
}

class WeatherData implements Comparable<WeatherData> {
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
  num insideTemperature;
  num insideHumidity;
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
        insideTemperature = json['inside_temperature'],
        insideHumidity = json['inside_humidity'],
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
        'inside_temperature': insideTemperature,
        'humidity': humidity,
        'inside_humidity': insideHumidity,
        'barometer': barometer,
        'solarradiation': solarradiation,
        'UV': UV,
        'rain': rain,
        'rain_today': rainToday,
        'raining': raining,
        'forecast': forecast,
      };

  @override
  int compareTo(WeatherData other) {
    if (distance != null && other.distance != null) {
      return distance.compareTo(other.distance);
    } else {
      return location.compareTo(other.location);
    }
  }
}
