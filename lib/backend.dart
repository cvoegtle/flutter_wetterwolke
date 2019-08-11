import 'package:http/http.dart' as http;

String _base_url = 'https://wettercentral.appspot.com//weatherstation/read?build=flutter';
Future<http.Response> fetchData(Set<String> locations, {String additional = ''}) {
  return http.get('${_base_url}&locations=${setToString(locations, ',')}${additional}');
}

String configuration_url = 'https://www.voegtle.org/~christian/ww/app/configuration.json';

Future<http.Response> fetchConfiguration() {
  return http.get(configuration_url);
}

String setToString(Set<String> set, String separator) {
  var str = "";
  set.forEach((item) => str += item + separator);
  return str.substring(0, str.length -1);
}
