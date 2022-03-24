import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

void searchFunc(_searchAddress, markers, mapController) async {
  //SearchService().getPlaceId(_searchController.text);
  List<Location> _searchPlacemark = await locationFromAddress(_searchAddress);

  double searchLatitude = _searchPlacemark[0].latitude;
  double searchLongitude = _searchPlacemark[0].longitude;
  String searchCoordinatesString = '($searchLatitude, $searchLongitude)';

  print(searchCoordinatesString);

  Marker searchMarker = Marker(
    markerId: MarkerId(searchCoordinatesString),
    position: LatLng(searchLatitude, searchLongitude),
    infoWindow: InfoWindow(
      title: 'Search $searchCoordinatesString',
      snippet: _searchAddress,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  markers.add(searchMarker);

  mapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          // Will be fetching in the next step
          searchLatitude,
          searchLongitude,
        ),
        zoom: 100.0,
      ),
    ),
  );
}
