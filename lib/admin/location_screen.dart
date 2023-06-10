import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodflutter/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  // const LocationScreen({super.key});
  String customerId;
  LocationScreen(this.customerId);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool loading = false;
  // Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition;
  late Location location;
  late LocationData currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();

    return loading
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("customers")
                    .doc(widget.customerId)
                    .update({
                  "lat": currentLocation.latitude,
                  "log": currentLocation.longitude
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return MyApp();
                }));
              },
              child: Text("OK"),
            ),
            body: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        : Scaffold(
            body: CircularProgressIndicator(),
          );
  }

  // void setInitialLocation()async{
  //   location = Location();
  //   LocationData currentLocation = await location.getLocation();
  //   initialCameraPosition = CameraPosition(target: target)
  // }

  void setInitialLocation() async {
    location = Location();
    currentLocation = await location.getLocation();
    initialCameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!));

    setState(() {
      this.loading = true;
    });
  }
}
