import 'dart:async';

import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';
import 'package:tracker/notification.dart';


class driverTrack extends StatefulWidget {
  @override
  _driverTrackState createState() => _driverTrackState();
}

class _driverTrackState extends State<driverTrack> {

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 15),

                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: polylineCoordinates,
                    color: Colors.red,
                    width: 6,
                  ),
                },


                markers: {

                  Marker(
                    markerId:MarkerId('source'),
                    // icon: sourceIcon,
                    position:LatLng(sourceLocation.latitude , sourceLocation.longitude),
                  ),

                  Marker(
                    markerId:MarkerId('bus'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                    position:LatLng(busLat , busLong),
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
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    children: [
                      Icon(Icons.location_on , color: Colors.red,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('school location' , style: TextStyle(fontSize: 15 , color: Colors.red),),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on , color: Colors.deepPurple,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('bus position' , style: TextStyle(fontSize: 15 , color: Colors.red),),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on , color: Colors.green,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('home location' , style: TextStyle(fontSize: 15 , color: Colors.red),),
                    ],
                  ),

                    Container(
                    child: Text('${placeDistance.toStringAsFixed(2)}'
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
      ),
    );

  }




  final Completer<GoogleMapController> controller = Completer();

  DatabaseReference ref =FirebaseDatabase.instance.ref(CacheHelper.getData(key: 'ID'));

  late GoogleMapController googleMapController;
  List<LatLng>polylineCoordinates = [];

  var placeDistance = 0.0;
  int? place;


  // var _placeDistance;
  static LatLng sourceLocation = LatLng(
      schoolLat,
      schoolLong
  );

  // static LatLng busLocation = LatLng(
  //     busLat,
  //     busLong
  // );


  static LatLng homeLocation = LatLng(
      contactLatitude[0],
      contactLongtude[0]
  );


  void getPolyPoints()async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(busLat, busLong),


      PointLatLng(homeLocation.latitude, homeLocation.longitude),
    );

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point)=>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude))
      );
      setState(() {});
    }

  }


  // void getPolyPoints2()async{
  //   PolylinePoints polylinePoints = PolylinePoints();
  //
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     googleAPIKey,
  //     PointLatLng(busLocation.latitude, busLocation.longitude),
  //
  //
  //     PointLatLng(homeLocation.latitude, homeLocation.longitude),
  //   );
  //
  //   if(result.points.isNotEmpty){
  //     result.points.forEach((PointLatLng point)=>
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude))
  //     );
  //     setState(() {});
  //   }
  //
  // }






  void getLiveLocation()async{

    var uid;



    GoogleMapController googleMapController = await controller.future;

    Geolocator.getPositionStream().listen((Position position) {
      print(LatLng(position.latitude, position.longitude));

      setState(() {
        busLat = position.latitude;
        busLong = position.longitude;
      });

      cal(position.latitude , position.longitude);



      FirebaseFirestore.instance.collection('users').get().
      then((value){
        value.docs.forEach((element){
          FirebaseFirestore.instance.collection('users').doc(element.data()['UID'])
              .collection('DRIVER').get().then((value){
            uid = element.data()['UID'];
            value.docs.forEach((element){
              if(element.data()['UID'] == CacheHelper.getData(key: 'ID')){
                FirebaseFirestore.instance.collection('users').doc(uid)
                    .collection('BUS').doc(element.data()['bus']).update(({
                  'latitude' : position.latitude,
                  'longtude' : position.longitude,
                }));
              }
            });
          });
        });
      });

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 20,
          target: LatLng(
              busLat,
              busLong
          )
      )));

      setState(() {

      });
    });


  }



  void cal(latitude , longtude)async{
    double distanceInMeters = await Geolocator.bearingBetween(
      latitude,
      longtude,
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
    setState(() {
//
      placeDistance = totalDistance.toDouble();
      ref.set(placeDistance.toInt());
      print('DISTANCE: $placeDistance km');
    });



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
    // getPolyPoints2();
    super.initState();
  }



}