import 'package:flutter/material.dart';

var ID;
var ID2;

var parentContact;

var schoolName , schoolEmail , schoolPhone;

String ?visitor;

List<dynamic>busNumbers = [];

List<dynamic>driverDetails = [];

List<dynamic>studentDetails = [];

List<dynamic>adminAndparents = [];


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