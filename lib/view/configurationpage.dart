import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPage extends StatefulWidget {
  final Configuration configuration;

  ConfigurationPage(this.configuration);

  @override
  State<StatefulWidget> createState() => ConfigurationState(configuration);
}

class ConfigurationState extends State<ConfigurationPage> {
  final Configuration configuration;

  ConfigurationState(this.configuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Konfiguration')),
        body: ListView(children: configuration.locations.map((
            LocationConfiguration location) {
          return CheckboxListTile(title: Text(location.city),
            value: location.enabled,
            onChanged: (bool state) {
              setState(() {
                _setLocationState(location.location, state);
              });
            },
            secondary: const Icon(Icons.location_on),);
        }).toList(),
        ));
  }

  _setLocationState(String locationId, bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(locationId, state);
    var location = configuration.locations.firstWhere((l) =>
    l.location == locationId);
    location.enabled = state;
  }


}

