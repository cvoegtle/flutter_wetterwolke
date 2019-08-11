import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/configuration.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:flutter_wetterwolke/weatherdata.dart';
import 'package:flutter_wetterwolke/weatherwidget.dart';

class WeatherDetailspage extends StatelessWidget {
  final WeatherData weatherData;
  final LocationConfiguration location;

  WeatherDetailspage(this.weatherData, this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('${this.weatherData.location} ${distance()}')),
        body: ListView(
            children: [WeatherDetails(this.weatherData, this.location)]));
  }

  String distance() {
    return format(weatherData.distance, postfix: "km", prefix: " - ");
  }
}
