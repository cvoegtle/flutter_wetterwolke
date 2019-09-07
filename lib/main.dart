import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/view/weatherwidget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'view/navigationbar.dart';

void main() {
  initializeDateFormatting("de_DE", null).then((_) => runWetterWolke());
}

void runWetterWolke() {
  runApp(new WetterWolkeApp());
}


class WetterWolkeApp extends StatefulWidget {
  WetterWolkeApp();

  @override
  WetterWolkeAppState createState() => WetterWolkeAppState();
}

class WetterWolkeAppState extends State<WetterWolkeApp> with WidgetsBindingObserver {
  var weatherModel = WeatherDataModel();

  @override
  void initState() {
    super.initState();
    weatherModel.init();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => weatherModel, child: WetterStartpage());
  }

  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      weatherModel.fetch();
    }
  }
  
}

class WetterStartpage extends StatelessWidget with WidgetsBindingObserver {
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
        primarySwatch: Colors.lightBlue,
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

