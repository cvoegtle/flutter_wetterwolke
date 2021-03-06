import 'package:http/http.dart' as http;

const String _base_url = 'https://wettercentral.appspot.com//weatherstation/read?build=flutter';
Future<http.Response> fetchData(Set<String> locations, {String additional = ''}) {
  var dataUrl = Uri.parse('$_base_url&locations=${setToString(locations, ',')}$additional');
  return http.get(dataUrl);
}

const String _base_stats_url = 'https://wettercentral.appspot.com//weatherstation/read?build=flutter&type=stats';
Future<http.Response> fetchStats(Set<String> locations, {String additional = ''}) {
  var statsUrl = Uri.parse('$_base_stats_url&locations=${setToString(locations, ',')}$additional');
  return http.get(statsUrl);
}

const String configuration_url = 'https://www.voegtle.org/~christian/ww/app/configuration.json';
Future<http.Response> fetchConfiguration() {
  var url = Uri.parse(configuration_url);
  return http.get(url);
}


String setToString(Set<String> set, String separator) {
  var str = "";
  set.forEach((item) => str += item + separator);
  return str.substring(0, str.length -1);
}
