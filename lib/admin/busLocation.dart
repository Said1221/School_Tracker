
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracker/constant/component.dart';

final Completer<GoogleMapController> controller = Completer();

Widget busLocation(index){
  LatLng sourceLocation = LatLng(
    lat[index],
    long[index],
  );
    return SafeArea(
      child: Scaffold(


        body:
        GoogleMap(
            initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 10.5),
            markers: {

              Marker(
                markerId:MarkerId('source'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                position:sourceLocation,
              ),

            },

            onMapCreated: (mapController){
              controller.complete(mapController);
            }

        ),

      ),
    );

  }
