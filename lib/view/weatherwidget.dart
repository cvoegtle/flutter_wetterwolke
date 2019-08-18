import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:flutter_wetterwolke/view/detailswidget.dart';
import 'package:intl/intl.dart';

class WeatherList extends StatelessWidget {
  final List<WeatherData> dataSets;
  final List<LocationConfiguration> locations;

  const WeatherList(this.dataSets, this.locations);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        int index = i ~/ 2;
        if (index < dataSets.length) {
          var dataSet = dataSets[index];
          return WeatherWidget(
              dataSet, configurationByLocation(locations, dataSet.id));
        } else {
          return null;
        }
      },
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;
  final LocationConfiguration location;

  const WeatherWidget(this.weatherData, this.location);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: WeatherTitle(this.weatherData),
      subtitle: WeatherDetails(this.weatherData),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WeatherDetailspage(this.weatherData, location)));
      },
    );
  }
}

class WeatherTitle extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherTitle(this.weatherData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.orange,
        padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
        child: Text(
          "${weatherData.location} - ${weatherData.localtime} ${distance()}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  String distance() {
    return format(weatherData.distance, postfix: "km", prefix: " - ");
  }
}

class WeatherDetails extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherDetails(this.weatherData);

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("#,###.#");
    List<Widget> rows = [
      Text("Temperatur: ${formatter.format(weatherData.temperature)}°C"),
      Text("Luftfeuchtigkeit: ${weatherData.humidity}%"),
    ];

    if (weatherData.barometer != null) {
      rows.add(
          Text("Luftdruck: ${formatter.format(weatherData.barometer)}hPa"));
    }

    if (weatherData.solarradiation != null) {
      rows.add(Text("Sonneneinstrahlung: ${weatherData.solarradiation}W/m²"));
    }

    if (weatherData.UV != null) {
      rows.add(Text("UV Index: ${formatter.format(weatherData.UV)}"));
    }

    if (weatherData.rain != null) {
      rows.add(Text("Regen 1h: ${formatter.format(weatherData.rain)}l/m²"));
    }

    if (weatherData.rainToday != null) {
      rows.add(
          Text("Regen heute: ${formatter.format(weatherData.rainToday)}l/m²"));
    }

    return Container(
        padding: EdgeInsets.only(left: 8, top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
        ));
  }
}
