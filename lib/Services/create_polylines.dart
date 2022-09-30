import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void createPolylines(_startAddress, _destinationAddress, markers, mapController,
    polylines) async {
  List<LatLng> polylineCoordinates = [];
  List<Location> _startPlacemark = await locationFromAddress(_startAddress);
  List<Location> _destinationPlacemark =
      await locationFromAddress(_destinationAddress);

  double startLatitude = _startPlacemark[0].latitude;
  double startLongitude = _startPlacemark[0].longitude;
  String startCoordinatesString = '($startLatitude, $startLongitude)';

  double destinationLatitude = _destinationPlacemark[0].latitude;
  double destinationLongitude = _destinationPlacemark[0].longitude;
  String destinationCoordinatesString =
      '($destinationLatitude, $destinationLongitude)';

  //print(startCoordinatesString);
  //print(destinationCoordinatesString);
  Marker startMarker = Marker(
      markerId: MarkerId(startCoordinatesString),
      position: LatLng(startLatitude, startLongitude),
      infoWindow: InfoWindow(
        title: 'Start $startCoordinatesString',
        snippet: _startAddress,
      ),
      icon: BitmapDescriptor.defaultMarker);
  Marker destinationMarker = Marker(
      markerId: MarkerId(destinationCoordinatesString),
      position: LatLng(destinationLatitude, destinationLongitude),
      infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress),
      icon: BitmapDescriptor.defaultMarker);

  markers.add(startMarker);
  markers.add(destinationMarker);

  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    "API KEY",
    PointLatLng(startLatitude, startLongitude),
    PointLatLng(destinationLatitude, destinationLongitude),
    travelMode: TravelMode.driving,
    optimizeWaypoints: true,
  );
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  } else {
    print(result.errorMessage);
  }
  PolylineId id = PolylineId("Route");
  Polyline route =
      Polyline(polylineId: id, points: polylineCoordinates, width: 10);
  polylines[id] = route;

  print(result.points);
  // Calculating to check that the position relative
  // to the frame, and pan & zoom the camera accordingly.
  double miny = (startLatitude <= destinationLatitude)
      ? startLatitude
      : destinationLatitude;
  double minx = (startLongitude <= destinationLongitude)
      ? startLongitude
      : destinationLongitude;
  double maxy = (startLatitude <= destinationLatitude)
      ? destinationLatitude
      : startLatitude;
  double maxx = (startLongitude <= destinationLongitude)
      ? destinationLongitude
      : startLongitude;

  double southWestLatitude = miny;
  double southWestLongitude = minx;

  double northEastLatitude = maxy;
  double northEastLongitude = maxx;

  // Accommodate the two locations within the
  // camera view of the map
  mapController.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(northEastLatitude, northEastLongitude),
        southwest: LatLng(southWestLatitude, southWestLongitude),
      ),
      100.0,
    ),
  );
}
