import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapPage extends StatelessWidget {
  final String title;
  final LatLng center;
  final List<WeatherData> weatherData;

  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  MapPage({Key key, this.title, this.center, this.weatherData})
      : super(key: key);

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 9.0,
              ),
              mapType: _currentMapType,
              markers: createMarkerForLocations(),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> createMarkerForLocations() {
    NumberFormat formatter = NumberFormat("#,###.#");
    return weatherData.map((dataSet) =>
        Marker(markerId: MarkerId(dataSet.id),
            position: LatLng(dataSet.latitude, dataSet.longitude),
            infoWindow: InfoWindow(title: dataSet.location, snippet: "${dataSet.temperature}°C / ${dataSet.humidity}%"),
        draggable: false)).toSet();
  }
}
