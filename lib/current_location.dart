import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  //const CurrentLocation({ Key? key }) : super(key: key);

  late GoogleMapController currentPositionController;
  CurrentLocation(this.currentPositionController);

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white70,
      onPressed: () {
        widget.currentPositionController;
      },
      child: Icon(Icons.my_location),
    );
  }
}
