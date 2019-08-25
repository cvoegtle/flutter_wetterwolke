import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:flutter_wetterwolke/view/detailswidget.dart';
import 'package:intl/intl.dart';

class WeatherList extends StatelessWidget {
  final List<WeatherData> dataSets;
  final List<LocationConfiguration> locations;
  WeatherListScrollController _scrollController;
  VoidCallback _onReload;
  BuildContext _context;

  WeatherList(this.dataSets, this.locations, {VoidCallback onReload}) {
    _onReload = onReload;
    _scrollController = WeatherListScrollController(onDrag);
  }
  
  void onDrag() {
    if (_onReload != null) {
      Scaffold.of(_context).showSnackBar(SnackBar(content: Text("Wetterdaten werden aktualisiert")));
      _onReload();
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return ListView.separated(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      itemCount: dataSets.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        var dataSet = dataSets[index];
        return WeatherWidget(
            dataSet, configurationByLocation(locations, dataSet.id));
      },
      separatorBuilder: (context, i) => Divider(),
    );
  }
}

class WeatherListScrollController extends ScrollController {
  DateTime _lastDrag = DateTime.now();

  WeatherListScrollController(VoidCallback onDrag) {
    addListener(() {
      DateTime now = DateTime.now();
      if (position.outOfRange &&
          offset <= (position.minScrollExtent - 30) &&
          now.difference(_lastDrag).inSeconds > 3 &&
          onDrag != null) {
        onDrag();
        _lastDrag = now;
      }
    }); 
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
  NumberFormat formatter = NumberFormat("#,###.#");

  WeatherDetails(this.weatherData);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [
      Text(temperatureText()),
      Text(humidityText()),
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

  String humidityText() {
    String insideHumidity = optional(weatherData.insideHumidity, "%");
    return "Luftfeuchtigkeit: ${weatherData.humidity}%$insideHumidity";
  }

  String temperatureText() {
    String insideTemperatureText =
        optional(weatherData.insideTemperature, "°C");
    return "Temperatur: ${formatter.format(weatherData.temperature)}°C$insideTemperatureText";
  }

  String optional(num value, String postfix) {
    return value != null ? " / $value$postfix" : "";
  }
}
