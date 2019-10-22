import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/tile_provider/tile_provider.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatelessWidget {
  final String title;
  final LatLng center;
  final List<WeatherData> weatherData;

  MapPage({Key key, this.title, this.center, this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: center,
            zoom: 6.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              tileProvider: CachedNetworkTileProvider(),
            ),
            new MarkerLayerOptions(
              markers: createMarkerForLocations(),
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> createMarkerForLocations() {
    NumberFormat formatter = NumberFormat("#,###.#");
    return weatherData.map((dataSet) =>
        Marker(width: 31,
            height: 44,
            point: LatLng(dataSet.latitude, dataSet.longitude),
          builder: (ctx) => new Container(
            child: Image(image: AssetImage('res/images/marker.png')),
          ), anchorPos: AnchorPos.align(AnchorAlign.top))).toList();
  }

}
