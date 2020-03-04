import 'dart:async';

import 'package:flutter_wetterwolke/data/configurationkey.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveConfigurationAsString(String jsonConfiguration) {
  SharedPreferences.getInstance().then((prefs) =>
      prefs.setString(ConfigurationKey.configuration, jsonConfiguration));
}

Completer<String> _completer = Completer<String>();

Future<String> fetchLocalConfiguration() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  _completer.complete(prefs.getString(ConfigurationKey.configuration));
  return _completer.future;
}
