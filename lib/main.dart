import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/view/weatherwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'view/navigationbar.dart';

void main() {
  Intl.defaultLocale = 'de_DE';

  var weatherModel = WeatherDataModel();
  weatherModel.init();

  runApp(ChangeNotifierProvider(
      builder: (context) => weatherModel, child: WetterStartpage()));
}

class WetterStartpage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wetter Wolke',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: Consumer<WeatherDataModel>(builder: (context, weatherData, child) =>
        Scaffold(
          appBar: AppBar(title: Text('Wetter Wolke')),
          bottomNavigationBar: NavigationBar(weatherData),
          body: Center(
              child: WeatherList(
            weatherData.dataSets,
            weatherData.configuration.locations,
            onReload: () {
              weatherData.fetch();
            },
          )),
        ),
      ),
    );
  }
}

