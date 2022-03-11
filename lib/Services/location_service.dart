import 'dart:async';
import 'package:location/location.dart';
import 'package:location/location.dart';
import '../models/user_location.dart';

class LocationService {
  // To keep track current location
  UserLocation? _currentLocation;
  Location location = Location();
  // Continuously update user location
  StreamController<UserLocation> _locationcontroller =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted as bool) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationcontroller.add(UserLocation(
                locationData.latitude as double,
                locationData.longitude as double));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationstream => _locationcontroller.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userlocation = await location.getLocation();
      _currentLocation = UserLocation(
          userlocation.latitude as double, userlocation.longitude as double);
    } catch (e) {
      print("Coundn't get the location: $e");
    }

    return _currentLocation!;
  }
}
