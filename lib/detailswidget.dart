import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:flutter_wetterwolke/weatherdata.dart';
import 'package:flutter_wetterwolke/weatherwidget.dart';

class WeatherDetailspage extends StatelessWidget {
  final WeatherData weatherData;
  WeatherDetailspage(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${this.weatherData.location} ${distance()}')), body: Center(
        child: WeatherDetails(this.weatherData)));
  }

  String distance() {
    return format(weatherData.distance, postfix: "km", prefix: " - ");
  }


}