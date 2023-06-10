import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodflutter/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLocation extends StatefulWidget {
  // const UserLocation({super.key});
  // String customerId;
  // LocationScreen(this.customerId);

  late double lat;
  late double log;
  UserLocation(this.lat, this.log);

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  bool loading = false;
  // Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition;
  late Location location;
  late LocationData currentLocation;
  Set<Marker> _marker = {};
  late BitmapDescriptor locationIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();

    return this.loading
        ? Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     FirebaseFirestore.instance
            //         .collection("customers")
            //         .doc(widget.customerId)
            //         .update({
            //       "lat": currentLocation.latitude,
            //       "log": currentLocation.longitude
            //     });
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) {
            //       return MyApp();
            //     }));
            //   },
            //   child: Text("OK"),
            // ),
            appBar: AppBar(title: Text("Customer Location")),
            body: GoogleMap(
              markers: _marker,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);

                LatLng pinPosition = LatLng(widget.lat, widget.log);

                setState(() {
                  _marker.add(Marker(
                      markerId: MarkerId("Icons"),
                      position: pinPosition,
                      icon: locationIcon));
                });
              },
            ),
          )
        : Scaffold(
            body: CircularProgressIndicator(),
          );
  }

  void setInitialLocation() async {
    setMapIcon();
    //   location = Location();
    //   LocationData currentLocation = await location.getLocation();
    // FirebaseFirestore.instance.collection("customers").doc();

    initialCameraPosition = CameraPosition(
        zoom: 16,
        // target: LatLng(currentLocation.latitude!, currentLocation.longitude!));
        target: LatLng(widget.lat, widget.log));

    setState(() {
      this.loading = true;
    });
  }

  void setMapIcon() async {
    locationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icon/map.png");
  }
}
