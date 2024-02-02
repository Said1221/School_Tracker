// import 'dart:async';
//
// import 'dart:math' show cos, sqrt, asin;
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';
// import 'package:tracker/constant/component.dart';
//
//
// class adminTrack extends StatefulWidget {
//   @override
//   _adminTrackState createState() => _adminTrackState();
// }
//
// class _adminTrackState extends State<adminTrack> {
//   final Completer<GoogleMapController> controller = Completer();
//
//   var _placeDistance;
//   static LatLng sourceLocation = LatLng(latitude, longitude);
//   static LatLng destination = LatLng(31.10341583043134, 29.767880486363396);
//
//   List<dynamic>Dis = [
//     {'latitude' : 31.104003759401245 , 'longitude' : 29.76719384086916},
//     {'latitude' : 31.0957724226152 , 'longitude' : 29.765477227133584},
//     {'latitude' : 31.08989245961883 , 'longitude' : 29.768567131857626},
//   ];
//
//   LocationData? currentLocation;
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//
//
//   void getLiveLocation()async{
//
//     GoogleMapController googleMapController = await controller.future;
//
//     Geolocator.getPositionStream().listen((Position position) {
//       print(LatLng(position.latitude, position.longitude));
//       cal();
//       sourceLocation = LatLng(position.latitude, position.longitude);
//
//       googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           zoom: 11,
//           target: LatLng(
//             position.latitude,
//             position.longitude,
//           )
//       )));
//
//       setState(() {
//
//       });
//     });
//
//   }
//
//   List<LatLng>polylineCoordinates = [];
//
//   void getPolyPoints()async{
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPIKey,
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//
//
//       PointLatLng(Dis[0]['latitude'], Dis[0]['longitude']),
//     );
//
//     if(result.points.isNotEmpty){
//       result.points.forEach((PointLatLng point)=>
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude))
//       );
//       setState(() {});
//     }
//
//   }
//
//   void setCustomMarkerIcon(){
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty,
//         "assets/bus.png"
//     ).then((value){
//       sourceIcon = value;
//     });
//     //
//     //   BitmapDescriptor.fromAssetImage(
//     //       ImageConfiguration.empty,
//     //       ""
//     //   ).then((value){
//     //     destinationIcon = value;
//     //   });
//     //
//     //   BitmapDescriptor.fromAssetImage(
//     //       ImageConfiguration.empty,
//     //       ""
//     //   ).then((value){
//     //     currentLocationIcon = value;
//     //   });
//   }
//
//   @override
//   void initState(){
//     getLiveLocation();
//     setCustomMarkerIcon();
//     getPolyPoints();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_placeDistance.toString()),
//       ),
//
//       body: GoogleMap(
//           initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 14.5),
//
//           polylines: {
//             Polyline(
//               polylineId: PolylineId('route'),
//               points: polylineCoordinates,
//               color: Colors.red,
//               width: 6,
//             )
//           },
//
//           markers: {
//             Marker(
//               markerId:MarkerId('source'),
//               // icon: sourceIcon,
//               position:sourceLocation,
//             ),
//
//             Marker(
//               markerId:MarkerId('destination'),
//               position:LatLng(Dis[0]['latitude'] , Dis[0]['longitude']),
//             ),
//
//           },
//
//           onMapCreated: (mapController){
//             controller.complete(mapController);
//           }
//
//       ),
//
//     );
//
//   }
//
//   void cal()async{
//     double distanceInMeters = await Geolocator.bearingBetween(
//       latitude,
//       longitude,
//       Dis[0]['latitude'],
//       Dis[0]['longitude'],
//     );
//
//     double _coordinateDistance(lat1, lon1, lat2, lon2) {
//       var p = 0.017453292519943295;
//       var c = cos;
//       var a = 0.5 -
//           c((lat2 - lat1) * p) / 2 +
//           c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//       return 12742 * asin(sqrt(a));
//     }
//
//     double totalDistance = 0.0;
//
// // Calculating the total distance by adding the distance
// // between small segments
//     for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance += _coordinateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//
// // Storing the calculated total distance of the route
//     setState(() {
//       _placeDistance = totalDistance.toStringAsFixed(2);
//       print('DISTANCE: $_placeDistance km');
//     });
//
//
//
//   }
//
// }