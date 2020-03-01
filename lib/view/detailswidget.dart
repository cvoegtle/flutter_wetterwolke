import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/formatter.dart';
import 'package:flutter_wetterwolke/view/diagramviewer.dart';
import 'package:flutter_wetterwolke/view/statisticsviewer.dart';
import 'package:flutter_wetterwolke/view/weatherwidget.dart';
import 'package:provider/provider.dart';

class WeatherDetailspage extends StatelessWidget {
  final WeatherData weatherData;
  final LocationConfiguration location;
  StatisticsModel statisticsModel;
  String title;

  WeatherDetailspage(this.weatherData, this.location) {
    statisticsModel = StatisticsModel(location.location);
    statisticsModel.fetch();
    title = "${this.weatherData.location} ${distance()}";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) {
          return statisticsModel;
        },
        child: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView(children: [
              DetailsTitle("Messwerte von ${weatherData.localtime}"),
              WeatherDetails(this.weatherData),
              DetailsTitle("Statistik"),
              Consumer<StatisticsModel>(
                  builder: (context, statisticsModel, child) {
                return Container(
                    padding: EdgeInsets.only(left: 8.0),
                    height: 120,                    
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        StatisticsViewer(statisticsModel.statistics)
                      ],
                    ));
              }),
              DetailsTitle("Diagramme"),
              DiagramPreviewer(title, location.diagrams)
            ])));
  }

  String distance() {
    return format(weatherData.distance, postfix: "km", prefix: " - ");
  }
}

class DetailsTitle extends StatelessWidget {
  final String text;

  const DetailsTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 8),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.orange)));
  }
}
