import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'package:geolocator/geolocator.dart';


void main() => runApp(Home());
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          // icon: BitmapDescriptor.fromBytes(),
            markerId: MarkerId(office.name),
            position: LatLng(office.lat, office.lng),
            infoWindow:
                InfoWindow(title: office.name, snippet: office.address));
        _markers[office.name] = marker;
      }
    });
  }

// GeoFirePoint center = geo.point(latitude: -33.870663, longitude: 
// 151.206793);
// var collectionReference = _firestore.collection('syd_places');

// double radius = 50; String field = 'position';

// Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
//     .within(center: center, radius: radius, field: field);

// stream.listen((List<DocumentSnapshot> documentList) {
//   // doSomething()
// }); 
    //2. Search for restaurants using the Places API
  // var placeApi = new places.GoogleMapsPlaces(apiKey);
  // var placeResponse = await placeApi.searchNearbyWithRadius(
  //     new places.Location(mapCenter.latitude, mapCenter.longitude), 200,
  //     type: "restaurant");


// void _add(LatLng position,String address) async{
// final MarkerId markerId = MarkerId('1');
// BitmapDescriptor markericon = await _getAssetIcon(context);

// // creating a new MARKER
// final Marker marker = Marker(
//   markerId: markerId,
//   position: position,
//   infoWindow: InfoWindow(title: address, snippet: 'go here'),
//   icon: markericon
// );

// setState(() {
//   _markers[markerId] = marker;
// });}





// Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

// void _add() {
//     // var markerIdVal = MyWayToGenerateId();
//     // final MarkerId markerId = MarkerId(markerIdVal);

//     // creating a new MARKER
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(

//         // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
//         // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
//       ),
//       infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
//       onTap: () {
//         // _onMarkerTapped(markerId);
//       },
//     );

//     setState(() {
//       // adding a new marker to map
//       markers[markerId] = marker;
//     });
// }

// GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(-33.852, 151.211),
//                 zoom: 11.0,
//               ),
//               // TODO(iskakaushik): Remove this when collection literals makes it to stable.
//               // https://github.com/flutter/flutter/issues/28312
//               // ignore: prefer_collection_literals
//               markers: Set<Marker>.of(markers.values), // YOUR MARKS IN MAP
// )

Position _position;


  Future _getCurrentUserLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _position = position;
    });
  }

  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;


//  void _onMapTypeButtonPressed() {
//     if (_currentMapType == MapType.normal) {
//       mapController.updateMapOptions(
//         GoogleMapOptions(mapType: MapType.satellite),
//       );
//       _currentMapType = MapType.satellite;
//     } else {
//       mapController.updateMapOptions(
//         GoogleMapOptions(mapType: MapType.normal),
//       );
//       _currentMapType = MapType.normal;
//     }
//   }

//   void _onAddMarkerButtonPressed() {
//     Marker marker = Marker(
//       position: 
//     );
    // mapController.addMarker(
    //   MarkerOptions(
    //     position: LatLng(
    //       mapController.cameraPosition.target.latitude,
    //       mapController.cameraPosition.target.longitude,
    //     ),
    //     infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor
    //         .hueViolet), //BitmapDescriptor.fromAsset('assets/pitch.png'),
    //   ),
    // );
  // }
  
// ==================================
// Google Maps for Flutter - Get new position of marker after dragging
// onCameraMove: ((_position) => _updateMarker(_position)),  

// void _updatePosition(CameraPosition _position) {
//     Position newMarkerPosition = Position(
//         latitude: _position.target.latitude,
//         longitude: _position.target.longitude);
//     Marker marker = markers["your_marker"];

//     setState(() {
//       markers["your_marker"] = marker.copyWith(
//           positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
//     });
//   }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Office Locations '),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: LatLng(0, 0) , zoom: 2),
        markers: _markers.values.toSet(),
      ),
          ),
        ],
      )
    );
  }
}
