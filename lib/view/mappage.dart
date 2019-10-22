import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/tile_provider/tile_provider.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
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
            zoom: 11.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              // For example purposes. It is recommended to use
              // TileProvider with a caching and retry strategy, like
              // NetworkTileProvider or CachedNetworkTileProvider
              tileProvider: CachedNetworkTileProvider(),
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(51.5, -0.09),
                  builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
