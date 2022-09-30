// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import '../models/direc_Details.dart';
import '../widgets/polyline_dialog.dart';

void getDirections(_startAddress, _destinationAddress, markers, mapController,
    polylines, context) async {
  Set<Polyline> polylineSet = {};

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

  Uri directionURL = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json?destination=${destinationLatitude},${destinationLongitude}&origin=${startLatitude},${startLongitude}&alternatives=true&key=${"API KEY"}");

  http.Response res = await http.get(directionURL);

  var result = jsonDecode(res.body);
  //print(result["routes"]);

  DirectionDetails directionDetails = DirectionDetails(
      result["routes"][1]["legs"][0]["distance"]["value"],
      result["routes"][1]["legs"][0]["duration"]["value"],
      result["routes"][1]["legs"][0]["distance"]["text"],
      result["routes"][1]["legs"][0]["duration"]["text"],
      result["routes"][1]["overview_polyline"]["points"]);

  print(directionDetails.distanceText);
  print(directionDetails.distanceValue);
  print(directionDetails.durationText);
  print(directionDetails.durationValue);
  print(directionDetails.polyPoints);

  var possible_encoded_paths = [];
  for (var i = 0; i < result["routes"].length; i += 1) {
    possible_encoded_paths
        .add(result["routes"][i]["overview_polyline"]["points"]);
  }
  print(possible_encoded_paths.length);

  polylines.clear();

  // Creating polyline 1
  List<LatLng> polylineCoordinates1 = [];
  var encodedPolylinePoints1 =
      result["routes"][0]["overview_polyline"]["points"];
  PolylinePoints polylinePoints1 = PolylinePoints();
  List<PointLatLng> decodedPolylinePointsResult1 =
      polylinePoints1.decodePolyline(encodedPolylinePoints1);
  if (decodedPolylinePointsResult1.isNotEmpty) {
    decodedPolylinePointsResult1.forEach((PointLatLng point) {
      polylineCoordinates1.add(LatLng(point.latitude, point.longitude));
    });
  }

  PolylineId id1 = const PolylineId("Route1");

  Polyline polyline1 = Polyline(
      color: Colors.blue,
      consumeTapEvents: true,
      polylineId: id1,
      points: polylineCoordinates1,
      width: 6,
      startCap: Cap.roundCap,
      onTap: () {
        print("Hope so");
        PolylineDialog(
            context,
            result["routes"][0]["legs"][0]["distance"]["text"],
            result["routes"][0]["legs"][0]["duration"]["text"]);
      });
  polylines[id1] = polyline1;

  // Creating polyline 2
  if (possible_encoded_paths.length > 1) {
    List<LatLng> polylineCoordinates2 = [];
    var encodedPolylinePoints2 =
        result["routes"][1]["overview_polyline"]["points"];
    PolylinePoints polylinePoints2 = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult2 =
        polylinePoints2.decodePolyline(encodedPolylinePoints2);
    if (decodedPolylinePointsResult2.isNotEmpty) {
      decodedPolylinePointsResult2.forEach((PointLatLng point) {
        polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id2 = PolylineId("Route2");

    Polyline polyline2 = Polyline(
        color: Colors.grey,
        consumeTapEvents: true,
        polylineId: id2,
        points: polylineCoordinates2,
        width: 6,
        startCap: Cap.roundCap,
        onTap: () {
          PolylineDialog(
              context,
              result["routes"][1]["legs"][0]["distance"]["text"],
              result["routes"][1]["legs"][0]["duration"]["text"]);
        });
    polylines[id2] = polyline2;
  }

  // Creating Polyline 3
  if (possible_encoded_paths.length > 2) {
    List<LatLng> polylineCoordinates3 = [];
    var encodedPolylinePoints3 =
        result["routes"][2]["overview_polyline"]["points"];
    PolylinePoints polylinePoints3 = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult3 =
        polylinePoints3.decodePolyline(encodedPolylinePoints3);
    if (decodedPolylinePointsResult3.isNotEmpty) {
      decodedPolylinePointsResult3.forEach((PointLatLng point) {
        polylineCoordinates3.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id3 = PolylineId("Route3");

    Polyline polyline3 = Polyline(
        color: Colors.grey,
        consumeTapEvents: true,
        polylineId: id3,
        points: polylineCoordinates3,
        width: 6,
        startCap: Cap.roundCap,
        onTap: () {
          PolylineDialog(
              context,
              result["routes"][2]["legs"][0]["distance"]["text"],
              result["routes"][2]["legs"][0]["duration"]["text"]);
        });
    polylines[id3] = polyline3;
  }

  // PolylinePoints polylinePoints = PolylinePoints();
  // List<PointLatLng> decodedPolylinePointsResults =
  //     polylinePoints.decodePolyline(directionDetails.polyPoints);
  // polylineCoordinates.clear();
  // if (decodedPolylinePointsResults.isNotEmpty) {
  //   decodedPolylinePointsResults.forEach((PointLatLng point) {
  //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //   });
  // }

  // PolylineId id = const PolylineId("Route");

  // Polyline polyline = Polyline(
  //     color: Colors.blue,
  //     polylineId: id,
  //     points: polylineCoordinates,
  //     width: 6,
  //     startCap: Cap.roundCap);
  // polylines[id] = polyline;

// Adding Markers for Source and Destination
  markers.clear();
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
