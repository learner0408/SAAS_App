import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saas/services/create_polylines.dart';

import '../widgets/modified_textfield.dart';
import '../Services/search_service.dart';
import '../services/get_directions.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: Home(),
//     );
//   }
// }

class Home extends StatefulWidget {
  static const routeName = '/home-page';
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  //final Completer<GoogleMapController> _controller = Completer();

  Map<PolylineId, Polyline> polylines = {};
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Marker'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  final _startAddressController = TextEditingController();
  final _destinationAddressController = TextEditingController();
  String _searchAddress = '';
  String _startAddress = '';
  String _destinationAddress = '';
  MapType _currentMapView = MapType.normal;

  Set<Marker> markers = {};

  void _DirectionInputs(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ModifiedTxtField(
                        _startAddressController,
                        "Start",
                        "From",
                        const Icon(Icons.radio_button_checked), (String val1) {
                      setState(() {
                        _startAddress = val1;
                      });
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: ModifiedTxtField(
                        _destinationAddressController,
                        "Destination",
                        "To",
                        const Icon(Icons.place), (String val2) {
                      setState(() {
                        _destinationAddress = val2;
                      });
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getDirections(_startAddress, _destinationAddress,
                                markers, mapController, polylines, ctx);
                          });

                          // final id = result.then((e) {
                          //   e['id'];
                          // });
                          // final route = result.then((e) {
                          //   e['route'];
                          // });

                          // setState(() {
                          //   polylines[id as PolylineId] = route as Polyline;
                          // });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Search")),
                  )
                ],
              ),
              behavior: HitTestBehavior.opaque);
        });
  }

  late GoogleMapController mapController;
  late Position _currentPosition;

  // Function for retreiving current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      //await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Changing Map View
  void _MapViewButton() {
    setState(() {
      if (_currentMapView == MapType.normal) {
        _currentMapView = MapType.hybrid;
      } else {
        _currentMapView = MapType.normal;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    markers.add(_kGooglePlexMarker);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Google Maps"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ModifiedTxtField(_searchController, "Search by city",
                      "Search", const Icon(Icons.search), (String value) {
                    setState(() {
                      _searchAddress = value;
                    });
                  }),
                )),
                IconButton(
                  onPressed: () =>
                      searchFunc(_searchAddress, markers, mapController),
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            Expanded(
              child: Stack(children: [
                GoogleMap(
                  mapType: _currentMapView,
                  markers: Set<Marker>.from(markers),
                  // polygons: {_kPolygon},
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white70,
                      onPressed: _MapViewButton,
                      child: const Icon(Icons.layers_rounded),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.white70,
              onPressed: () {
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        // Will be fetching in the next step
                        _currentPosition.latitude,
                        _currentPosition.longitude,
                      ),
                      zoom: 18.0,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
                backgroundColor: Colors.white70,
                onPressed: () => _DirectionInputs(context),
                child: const Icon(Icons.assistant_direction)),
            const SizedBox(
              height: 15,
            )
          ],
        ));
  }
}
