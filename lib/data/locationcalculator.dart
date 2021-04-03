import 'dart:math';

import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:location/location.dart';
import 'package:location_permissions/src/permission_enums.dart';
import 'package:location_permissions/location_permissions.dart' as permissions;
import 'package:vector_math/vector_math.dart';

class LocationProvider {
  Position currentPosition;
  bool permissionGranted = false;
  var location = new Location();

  void fetchWithPermissionCheck(void Function() proceedProcessing) {
    try {
      permissions.LocationPermissions().requestPermissions(permissionLevel: LocationPermissionLevel.locationWhenInUse).then((
          permissionStatus) {
        this.permissionGranted =
            permissionStatus == permissions.PermissionStatus.granted;
        fetch(proceedProcessing);
      }, onError: (_) {
        _proceedWithoutLocation(proceedProcessing);
      }).catchError((_) {
        _proceedWithoutLocation(proceedProcessing);
      });
    } catch (e) {
      print("Exception on permission check: " + e);
    }
  }

  void fetch(void Function() proceedProcessing) {
    if (permissionGranted) {
      _fetchIfServiceAvailable((proceedProcessing));
    } else {
      _proceedWithoutLocation(proceedProcessing);
    }
  }

  void _fetchIfServiceAvailable(void Function() proceedProcessing) async {
    var serviceAvailable = await location.serviceEnabled();
    if (serviceAvailable) {
      serviceAvailable = await location.requestService();
      if (serviceAvailable) {
        var currentLocation = await location.getLocation();
        _updateLocation(currentLocation);
      }
    }

    proceedProcessing();
  }

  void _proceedWithoutLocation(void Function() proceedProcessing) {
    currentPosition = null;
    proceedProcessing();
  }

  _updateLocation(LocationData newLocation) {
    if (newLocation != null) {
      currentPosition = Position(newLocation.latitude, newLocation.longitude);
    }
  }

  void calculateDistances(List<WeatherData> receivedLocations) {
    if (currentPosition != null) {
      for (WeatherData weatherData in receivedLocations) {
        weatherData.distance = currentPosition
            .distanceTo(Position(weatherData.latitude, weatherData.longitude));
      }
    }
  }
}

class Position {
  static const double _EARTH_RADIUS = 6371.0; // Approx Earth radius in KM

  final double latitude;
  final double longitude;

  Position(this.latitude, this.longitude);

  Position minus(Position subtract) {
    return Position(
        this.latitude - subtract.latitude, this.longitude - subtract.longitude);
  }

  double distanceTo(Position position) {
    final diff = this.minus(position);

    double diffLat = radians(diff.latitude);
    double diffLong = radians(diff.longitude);

    double startLat = radians(this.latitude);
    double endLat = radians(position.latitude);

    double a =
        haversin(diffLat) + cos(startLat) * cos(endLat) * haversin(diffLong);
    return 2 * _EARTH_RADIUS * asin(sqrt(a));
  }

  double haversin(double value) {
    return pow(sin(value / 2), 2.0);
  }
}
