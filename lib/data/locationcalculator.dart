import 'dart:math';

import 'package:flutter_wetterwolke/data/weatherdata.dart';
import 'package:location/location.dart';
import 'package:vector_math/vector_math.dart';

class LocationProvider {
  Position currentPosition;
  bool permissionGranted = false;
  var location = new Location();

  void fetchWithPermissionCheckIfEnabled(void Function() proceedProcessing) {
    location.serviceEnabled().then((enabled){
      if (enabled) {
        _fetchWithPermissionCheck(proceedProcessing);
      } else {
        _proceedWithoutLocation(proceedProcessing);
      }
    }, onError: (_) {
      _proceedWithoutLocation(proceedProcessing);
    });
  }

  void _fetchWithPermissionCheck(void proceedProcessing()) {
    location.requestPermission().then((permissionStatus) {
      this.permissionGranted = permissionStatus == PermissionStatus.GRANTED;
      fetch(proceedProcessing);
    }, onError: (_) {
      _proceedWithoutLocation(proceedProcessing);
    });
  }

  void fetch(void Function() proceedProcessing) {
    if (permissionGranted) {
      _fetchIfServiceAvailable((proceedProcessing));
    } else {
      _proceedWithoutLocation(proceedProcessing);
    }
  }

  void _fetchIfServiceAvailable(void Function() proceedProcessing) {
    location.serviceEnabled().then((enabled){
      if (enabled) {
        _fetchIfAllowed(proceedProcessing);
      } else {
        _proceedWithoutLocation(proceedProcessing);
      }
    }, onError: (_) {
      _proceedWithoutLocation(proceedProcessing);
    });
  }


  _fetchIfAllowed(void Function() proceedProcessing) {
    try {
      location.getLocation().then((locationData) {
        _updateLocation(locationData);
        proceedProcessing();
      }).catchError((_) {
        proceedProcessing();
      }).whenComplete(() => proceedProcessing());
    } catch (ex) {
      proceedProcessing();
    }
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
