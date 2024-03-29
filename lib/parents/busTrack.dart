import 'dart:async';

import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';
import 'package:tracker/state.dart';


class busTrack extends StatefulWidget {
  @override
  _busTrackState createState() => _busTrackState();
}

class _busTrackState extends State<busTrack> {
  final Completer<GoogleMapController> controller = Completer();

  late GoogleMapController googleMapController;
  List<LatLng>polylineCoordinates = [];

  // var _placeDistance;
  static LatLng sourceLocation = LatLng(
    CacheHelper.getData(key: 'latitude'),
    CacheHelper.getData(key: 'longitude') ,
  );

  static LatLng busLocation = LatLng(busLocationLati, busLocationLong);


  void getPolyPoints()async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),


      PointLatLng(schoolLocationLati, schoolLocationLong),
    );

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point)=>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude))
      );
      setState(() {});
    }

  }


  // void getLiveLocation()async{
  //
  //   GoogleMapController googleMapController = await controller.future;
  //
  //   Geolocator.getPositionStream().listen((Position position) {
  //     print(LatLng(busLocation.latitude, busLocation.longitude));
  //     // cal();
  //     busLocation = LatLng(busLocation.latitude, busLocation.longitude);
  //
  //     googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         zoom: 15,
  //         target: LatLng(
  //           busLocation.latitude,
  //           busLocation.longitude
  //         )
  //     )));
  //
  //     setState(() {
  //
  //     });
  //   });
  //
  // }




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
    // getLiveLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getParentsContact(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          return SafeArea(
            child: Scaffold(
              body: state is AppGetParentsContactSuccessState ?
              Stack(
                children: [
                  GoogleMap(
                      initialCameraPosition: CameraPosition(target: busLocation , zoom: 15),

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
                          markerId:MarkerId('destination'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                          position:LatLng(schoolLocationLati , schoolLocationLong),
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
              ) :
              Center(child: CircularProgressIndicator(color: Colors.blue,)),
            ),
          );
          },
      ),
    );

  }


}