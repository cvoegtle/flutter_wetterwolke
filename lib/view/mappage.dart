import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/tile_provider/tile_provider.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:flutter_wetterwolke/view/detailswidget.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatelessWidget {
  final String title;
  final LatLng center;
  final List<WeatherData> weatherData;
  final List<LocationConfiguration> locations;

  MapPage({Key key, this.title, this.center, this.weatherData, this.locations})
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
              markers: createMarkerForLocations(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> createMarkerForLocations(BuildContext context) {
    NumberFormat formatter = NumberFormat("#,###.#");
    return weatherData
        .map((dataSet) => Marker(
            height: 44,
            width: 80,
            point: LatLng(dataSet.latitude, dataSet.longitude),
            builder: (ctx) => GestureDetector(
                child: Row(children: <Widget>[
                  Image(image: AssetImage('res/images/marker.png')),
                  Text(
                    "${formatter.format(dataSet.temperature)}°C",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherDetailspage(dataSet,
                              configurationByLocation(locations, dataSet.id))));
                }),
            anchorPos: AnchorPos.exactly(Anchor(80.0-16.0, 0))))
        .toList();
  }
}
