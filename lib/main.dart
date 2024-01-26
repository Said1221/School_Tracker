import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tracker/onBoardScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ? await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyC8Xsd5Rx98EwYaOEkaCmIzUFf0FP-FU8E',
        appId: '1:1063852509526:android:b327590f1f86484e026ef7',
        messagingSenderId: '1063852509526',
        projectId: 'school-tracker-f629e'
    )
  ):await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  onBoarding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
