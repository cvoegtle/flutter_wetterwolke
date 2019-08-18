import 'dart:convert';

Configuration readConfiguration(String jsonString) {
  Map<String, dynamic> json = jsonDecode(jsonString);
  return Configuration.fromJson(json);
}

class Configuration {
  final List<DiagramConfiguration> diagramsOverall;
  final List<LocationConfiguration> locations;

  Configuration(this.diagramsOverall, this.locations);

  Configuration.fromJson(Map<String, dynamic> json)
      : diagramsOverall = fromJsonDiagrams(json['diagrams']),
        locations = fromJsonLocations(json['locations']);

  Map<String, dynamic> toJson() => {
        'diagrams': toJsonDiagrams(diagramsOverall),
        'locations': toJsonLocations(locations)
      };
}

class DiagramConfiguration {
  final String description;
  final String url;

  DiagramConfiguration(this.description, this.url);

  DiagramConfiguration.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'description': description, 'url': url};
}

class LocationConfiguration {
  final String location;
  final String city;
  final String cityShortcut;
  final String weatherForecast;
  final bool windRelevant;
  final List<DiagramConfiguration> diagrams;
  bool enabled = false;

  LocationConfiguration(this.location, this.city, this.cityShortcut,
      this.weatherForecast, this.windRelevant, this.diagrams);

  LocationConfiguration.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        city = json['city'],
        cityShortcut = json['cityShortcut'],
        weatherForecast = json['weatherForecast'],
        windRelevant = json['windRelevant'],
        diagrams = fromJsonDiagrams(json['diagrams']);

  Map<String, dynamic> toJson() => {
        'location': location,
        'city': city,
        'cityShortcut': cityShortcut,
        'weatherForecast': weatherForecast,
        'windRelevant': windRelevant,
        'diagrams': toJsonDiagrams(diagrams)
      };
}

List<dynamic> toJsonDiagrams(List<DiagramConfiguration> diagrams) {
  List<dynamic> jsonDiagrams = [];
  diagrams.forEach((d) => jsonDiagrams.add(d.toJson()));
  return jsonDiagrams;
}

List<dynamic> toJsonLocations(List<LocationConfiguration> locations) {
  List<dynamic> jsonLocations = [];
  locations.forEach((l) => jsonLocations.add(l.toJson()));
  return jsonLocations;
}

List<DiagramConfiguration> fromJsonDiagrams(List<dynamic> json) {
  List<DiagramConfiguration> diagrams = [];
  json.forEach((j) => diagrams.add(DiagramConfiguration.fromJson(j)));
  return diagrams;
}

fromJsonLocations(List<dynamic> json) {
  List<LocationConfiguration> locations = [];
  json.forEach((j) => locations.add((LocationConfiguration.fromJson(j))));
  return locations;
}

LocationConfiguration configurationByLocation(
    List<LocationConfiguration> locations, String location) {
  LocationConfiguration foundLocation;
  locations.forEach((l) { if (l.location == location) foundLocation = l;});
  return foundLocation;
}
