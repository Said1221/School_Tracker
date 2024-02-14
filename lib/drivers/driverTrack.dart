import 'dart:async';


import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/constant/dio_helper.dart';
import 'package:tracker/cubit.dart';
import 'package:tracker/notification.dart';
import 'package:tracker/state.dart';


class driverTrack extends StatefulWidget {
  @override
  _driverTrackState createState() => _driverTrackState();
}

class _driverTrackState extends State<driverTrack> {

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getDriverContact(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext contetx , AppState state){},
          builder: (BuildContext context , AppState state){
          return SafeArea(
            child: Scaffold(
              body: state is AppGetDriverContactSuccessState ?
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
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
                                position:LatLng(contactLatitude[x] , contactLongtude[x]),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Distance :- ${placeDistance.toStringAsFixed(2)} KM' ,
                                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Remaining Time :- ${totalHours}' ,
                                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.red),)

                              ],
                            ),
                            Column(
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 35,
                                    child: TextButton(
                                      onPressed: (){

                                        setState(() {

                                          if( y < contactToken.length){
                                            dioHelper.postFCM(
                                                url: 'send',
                                                data: {
                                                  'to' : '${contactToken[x].toString()}',
                                                }
                                            ).then((value){
                                              y += 1;
                                              print(value);
                                            });
                                            if(x != contactLatitude.length-1){
                                              getPolyPoints();
                                              x += 1;
                                            }
                                          }

                                          else{
                                            Fluttertoast.showToast(
                                                msg: 'all students were successfully arrived \n go back to school',
                                                timeInSecForIosWeb: 3,
                                                gravity: ToastGravity.BOTTOM,
                                                textColor: Colors.white,
                                                toastLength: Toast.LENGTH_LONG,
                                                fontSize: 16,
                                                backgroundColor: Colors.green
                                            );
                                          }
                                        });
                                      },
                                      child: Text('End', style: TextStyle(color: Colors.white , fontSize: 20)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ) :
              Center(child: CircularProgressIndicator(color: Colors.blue,))

            ),
          );
          },
      ),
    );

  }





  final Completer<GoogleMapController> controller = Completer();

  DatabaseReference ref =FirebaseDatabase.instance.ref(CacheHelper.getData(key: 'ID'));

  late GoogleMapController googleMapController;
  List<LatLng>polylineCoordinates = [];

  var placeDistance = 0.0;
  var totalHours = '0 min' ;
  Dio dio = new Dio();
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


  // static LatLng homeLocation = LatLng(
  //     contactLatitude[x],
  //     contactLongtude[x]
  // );


  void getPolyPoints()async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(busLat, busLong),


      PointLatLng(contactLatitude[x], contactLongtude[x]),
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
        // cal(busLat, busLong);
        cal();
      });

      // cal(position.latitude , position.longitude);



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



  void cal()async{
    // latitude , longtude
    // double distanceInMeters = await Geolocator.bearingBetween(
    //   latitude,
    //   longtude,
    //   homeLocation.latitude,
    //   homeLocation.longitude,
    // );

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
        busLat,
        busLong,
        contactLatitude[x],
        contactLongtude[x],
      );
    }

    await dio.get('https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${busLat},${busLong}&origins=${contactLatitude[x]},${contactLongtude[x]}&units=imperial&key=${googleAPIKey}').then((value){
      print(value.data['rows'][0]['elements'][0]['duration']['text'].toString());
      setState(() {
        totalHours = value.data['rows'][0]['elements'][0]['duration']['text'].toString();
      });
    });


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