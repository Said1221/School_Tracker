import 'dart:async';

import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';


class driverTrack extends StatefulWidget {
  @override
  _driverTrackState createState() => _driverTrackState();
}

class _driverTrackState extends State<driverTrack> {
  final Completer<GoogleMapController> controller = Completer();

  late GoogleMapController googleMapController;
  List<LatLng>polylineCoordinates = [];

  var placeDistance;



  // var _placeDistance;
  static LatLng sourceLocation = LatLng(
    schoolLat,
    schoolLong
  );

  static LatLng busLocation = LatLng(
      busLat,
      busLong
  );


  static LatLng homeLocation = LatLng(contactLatitude[0], contactLongtude[0]);


  void getPolyPoints()async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),


      PointLatLng(homeLocation.latitude, homeLocation.longitude),
    );

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point)=>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude))
      );
      setState(() {});
    }

  }




  void getLiveLocation()async{

    GoogleMapController googleMapController = await controller.future;

    Geolocator.getPositionStream().listen((Position position) {
      print(LatLng(position.latitude, position.longitude));
      cal();
      busLocation = LatLng(position.latitude, position.longitude);

      FirebaseFirestore.instance.collection('users').doc('8mUyvkEnotPLpIgKvRv0JZAZsxo2')
      .collection('BUS').doc('1010').set(({
        'latitude' : position.latitude,
        'longtude' : position.longitude,
      }));

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 20,
          target: LatLng(
            busLocation.latitude,
            busLocation.longitude
          )
      )));

      setState(() {

      });
    });

  }



  void cal()async{
    double distanceInMeters = await Geolocator.bearingBetween(
      busLocation.latitude,
      busLocation.longitude,
      homeLocation.latitude,
      homeLocation.longitude,
    );

    double _coordinateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    double totalDistance = 0.0;

// Calculating the total distance by adding the distance
// between small segments
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

// Storing the calculated total distance of the route
//     setState(() {
      placeDistance = totalDistance.toStringAsFixed(2);
      print('DISTANCE: $placeDistance km');
    // });



  }




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
    getLiveLocation();
    getPolyPoints();
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
              initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 15),

              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: polylineCoordinates,
                  color: Colors.red,
                  width: 6,
                )
              },


              markers: {

                Marker(
                  markerId:MarkerId('source'),
                  // icon: sourceIcon,
                  position:sourceLocation,
                ),

                Marker(
                  markerId:MarkerId('bus'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                  position:busLocation,
                ),

                Marker(
                  markerId:MarkerId('home'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position:LatLng(homeLocation.latitude , homeLocation.longitude),
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

                Container(
                  child: Text('${placeDistance.toString()}'),
                ),
              ],
            ),
          ),
        ],
      ),

    );

  }


}