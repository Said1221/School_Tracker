import 'dart:async';

import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';


class adminTrack extends StatefulWidget {
  @override
  _adminTrackState createState() => _adminTrackState();
}

class _adminTrackState extends State<adminTrack> {
  final Completer<GoogleMapController> controller = Completer();

  late GoogleMapController googleMapController;

  // var _placeDistance;
  static LatLng sourceLocation = LatLng(
    CacheHelper.getData(key: 'latitude'),
    CacheHelper.getData(key: 'longitude') ,
  );




  // LocationData? currentLocation;
  //
  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;




  // void setCustomMarkerIcon(){
  //   BitmapDescriptor.hueBlue;
  // //
  // //   BitmapDescriptor.fromAssetImage(
  // //       ImageConfiguration.empty,
  // //       ""
  // //   ).then((value){
  // //     destinationIcon = value;
  // //   });
  // //
  // //   BitmapDescriptor.fromAssetImage(
  // //       ImageConfiguration.empty,
  // //       ""
  // //   ).then((value){
  // //     currentLocationIcon = value;
  // //   });
  // }

  @override
  void initState(){
    // setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ]
              )
          ),
        ),
      ),

      body:
      Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 10.5),
              markers: {

                Marker(
                  markerId:MarkerId('source'),
                  // icon: sourceIcon,
                  position:sourceLocation,
                ),

                for(int x = long.length-1 ; x>=0 ; x--)
                  Marker(

                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                    markerId:MarkerId('destination'),
                    position:LatLng(lat[x] , long[x]),
                  ),

              },

              onMapCreated: (mapController){
                controller.complete(mapController);
              }

          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('<< Go To >>' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),

                Row(
                  children: [

                    Expanded(
                      child: TextButton(onPressed: (){
                      },
                          child: Text('Your school location' , style: TextStyle(fontSize: 15 , color: Colors.red),)
                      ),
                    ),

                    Expanded(
                      child: TextButton(onPressed: (){

                      },
                          child: Text('all buses location', style: TextStyle(fontSize: 15 , color: Colors.green),)
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),

    );

  }


}