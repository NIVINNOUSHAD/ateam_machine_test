import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  late Position _currentPosition;
  late LatLng updatedPosition = LatLng(0.0, 0.0);
  Set<Marker> markers = {};

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        updatedPosition = LatLng(position.latitude, position.longitude);
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12.0,
            ),
          ),
        );
        markers.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
        ));
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Set<Circle> setGeofence() {
    Set<Circle> circles = Set.from([
      Circle(
        circleId: CircleId('1'),
        center: updatedPosition,
        radius: 6213,
        strokeWidth: 1,
        strokeColor: Colors.red,
        fillColor: Colors.black12,
      )
    ]);
    return circles;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: markers,
        initialCameraPosition: _initialLocation,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        circles: updatedPosition != null ? setGeofence() : const <Circle>{},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _getCurrentLocation();
        },
        label: Text('find my location'),
        icon: Icon(Icons.location_on),
      ),
    );
  }
}
