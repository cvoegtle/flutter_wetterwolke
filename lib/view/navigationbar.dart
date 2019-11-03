import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/view/diagramviewer.dart';
import 'package:flutter_wetterwolke/view/infopage.dart';
import 'package:flutter_wetterwolke/view/mappage.dart';
import 'package:flutter_wetterwolke/view/snackbars.dart';
import 'package:latlong/latlong.dart';

import '../data/configuration.dart';
import 'configurationpage.dart';

class NavigationBar extends StatelessWidget {
  final WeatherDataModel weatherData;

  const NavigationBar(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        NavigationButton(
          icon: Icon(Icons.cloud_download),
          onPressed: () {
            Scaffold.of(context).showSnackBar(UpdateDataSnackBar());
            this.weatherData.fetch();
          },
        ),
        NavigationButton(
          icon: Icon(
            Icons.photo_library,
          ),
          onPressed: () {
            navigateToDiagrams(
                context, weatherData.configuration.diagramsOverall);
          },
        ),
        NavigationButton(
          icon: Icon(Icons.map),
          onPressed: () {
            navigateToMap(context, weatherData.dataSets);
          },
        ),
        NavigationButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              navigateToConfiguration(context, weatherData.configuration);
            }),
        NavigationButton(
          icon: Icon(Icons.info),
          onPressed: () {
            navigateToInfo(context);
          },
        )
      ],
    );
  }

  void navigateToDiagrams(
      BuildContext context, List<DiagramConfiguration> diagrams) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DiagramPage("Diagramme", diagrams)));
  }

  void navigateToConfiguration(
      BuildContext context, Configuration configuration) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfigurationPage(configuration)));
    weatherData.reinitialize();
  }

  void navigateToInfo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage()));
  }

  void navigateToMap(
      BuildContext context, UnmodifiableListView<WeatherData> weatherData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapPage(
                title: "Wetter Wolke - Kartenansicht",
                center: LatLng(51.7274315, 8.7348741),
                weatherData: weatherData,
                locations: this.weatherData.configuration.locations)));
  }
}

class NavigationButton extends IconButton {
  NavigationButton({Icon icon, VoidCallback onPressed})
      : super(icon: icon, onPressed: onPressed, iconSize: 28.0);
}
