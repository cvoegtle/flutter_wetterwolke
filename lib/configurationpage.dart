import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPage extends StatelessWidget {
  final Configuration configuration;

  ConfigurationPage(this.configuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Konfiguration')),
        body: ListView(children: configuration.locations.map((
            LocationConfiguration location) {
          return CheckboxListTile(title: Text(location.city),
              value: location.enabled,
              onChanged: (bool state) {
                _setLocationState(location.location, state);
              });
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

