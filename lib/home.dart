import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saas/location_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _searchController = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Marker'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  static final Marker _kLakeMarker = Marker(
      markerId: MarkerId('_kLake'),
      infoWindow: InfoWindow(title: 'Lake'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.43296265331129, -122.08832357078792));

  static final Polygon _kPolygon = Polygon(
    polygonId: PolygonId('kPolygon'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.258, -122.087),
      LatLng(37.675, -122.234)
    ],
    fillColor: Colors.transparent,
    strokeWidth: 5,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Google Maps"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(hintText: 'Search By City'),
                    textCapitalization: TextCapitalization.words,
                    // onChanged: (value) => print(value),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    LocationService().getPlaceId(_searchController.text);
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.hybrid,
                markers: {_kGooglePlexMarker},
                // polygons: {_kPolygon},
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
