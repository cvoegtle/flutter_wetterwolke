import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/backend.dart';
import 'package:http/src/response.dart';

void main() {
  test('Stats', () {
    var locations = Set<String>();
    locations.add('tegelweg8');
    locations.add('wetterwolke');
    var future = fetchData(locations, additional: '&type=stats');
    future.then(expectAsync1((Response response) {
      expect(200, response.statusCode);
      var json = jsonDecode(response.body);
      json.toString();
    })).catchError((error) => processError(error));
  });
}

processError(error) {
  print(error);
}
