
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/configuration.dart';

class ConfigurationPage extends StatelessWidget {
  final Configuration configuration;

  const ConfigurationPage(this.configuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konfiguration')),
     body: ListView(children: configuration.locations.map((LocationConfiguration location) {
       return CheckboxListTile(title: Text(location.city),
           value: false,
           onChanged: (bool state) {
             var val = location.location;
           });
     }).toList(),
    ));
  }


}