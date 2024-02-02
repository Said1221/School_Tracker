import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracker/cache_helper.dart';

var ID;
var ID2;

var parentContact;
var parentContact2;
var parentContact3;

var schoolLocationLati , schoolLocationLong;
var busLocationLati , busLocationLong;
var homeLocationLati , homeLocationLong;

var schoolName , schoolEmail , schoolPhone , adminUID;
var driverName , driverEmail , driverPhone;
var studentName , studentAddress , studentPhone;

var schoolLat , schoolLong ;

var busLat , busLong ;

String ?visitor;

List<dynamic>busNumbers = [];

List<String> dropButton = [];

List<dynamic>driverDetails = [];

List<dynamic>studentDetails = [];

List<dynamic>adminAndparents = [];

List<dynamic>contactsName = [];
List<dynamic>contactsAddress = [];
List<dynamic>contactsPhone = [];
List<dynamic>contactsClass = [];
List<dynamic>contactLatitude = [];
List<dynamic>contactLongtude = [];


List<dynamic>lat = [];
List<dynamic>long = [];


String googleAPIKey = 'AIzaSyAMPA3WK_y4Q4QRUrsejPy4J_K4BnvArtE';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.all(
    10
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  ),
);

void NavigatAndFinish (context , widget)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (Route<dynamic>route) => false);


//
var city;

Future<Position>getCurrentAddress()async{
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnable){
    return Future.error('location error');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error('location permission are dened');
    }
  }

  if(permission == LocationPermission.deniedForever){
    return Future.error('location permission forever');
  }


  return await Geolocator.getCurrentPosition().then((value)async{
    CacheHelper.saveData(key: 'latitude', value: value.latitude);
    CacheHelper.saveData(key: 'longitude', value: value.longitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        CacheHelper.getData(key: 'latitude') ,
      CacheHelper.getData(key: 'longitude') ,
    );
    city = placemarks[0].administrativeArea;

    return city;

  });

}