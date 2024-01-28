// import 'package:dio/dio.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'constant/component.dart';
// import 'directions_model.dart';
//
// class DirectionsRepository{
//   static String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
//
//   late final Dio dio;
//
//   DirectionsRepository({Dio? dio}) : dio=dio ?? Dio();
//
//   Future<Directions?>getDirections({
//     required LatLng origin,
//     required LatLng destination,
// })async{
//     final response = await dio.get(
//       baseUrl,
//       queryParameters: {
//         'origin' : '${origin.latitude} , ${origin.longitude}',
//         'destination' : '${destination.latitude} , ${destination.longitude}',
//         'api' : googleAPIKey,
//       }
//     );
//
//     if(response.statusCode == 200){
//       return Directions.fromMap(response.data);
//     }
//     print('ooooooooooooooooooooooooooooooooooooooo');
//     print('${origin.latitude} , ${origin.longitude}');
//     print('dddddddddddddddddddddddddddddddddddddddddd');
//     print('${destination.latitude} , ${destination.longitude}');
//   }
// }