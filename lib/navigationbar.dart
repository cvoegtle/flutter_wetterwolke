import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/diagramviewer.dart';
import 'package:flutter_wetterwolke/weatherdata.dart';

import 'configuration.dart';
import 'configurationpage.dart';

class NavigationBar extends StatelessWidget {
  final WeatherDataModel weatherData;

  const NavigationBar(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        IconButton(icon: Icon(Icons.photo_library,),
        onPressed: () {
          navigateToDiagrams(context, weatherData.configuration.diagramsOverall);
        },),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              navigateToConfiguration(context, weatherData.configuration);
            })
      ],
    );
  }

  void navigateToDiagrams (BuildContext context, List<DiagramConfiguration> diagrams) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DiagramViewer("Diagramme", diagrams)));
  }

  void navigateToConfiguration(BuildContext context, Configuration configuration) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfigurationPage(configuration)));
    weatherData.reinitialize();
  }

}

