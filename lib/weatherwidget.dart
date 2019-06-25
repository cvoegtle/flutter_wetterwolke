import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/weatherdata.dart';

class WeatherList extends StatelessWidget {
  final List<WeatherData> dataSets;

  const WeatherList(this.dataSets);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        int index = i ~/ 2;
        if (index < dataSets.length) {
          return WeatherWidget(dataSets[index]);
        } else {
          return null;
        }
      },
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherWidget(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${weatherData.location_short} - ${weatherData.temperature}°C"),
    );
  }
}
