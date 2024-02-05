import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/adminLayout.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/dio_helper.dart';
import 'package:tracker/driverLayout.dart';
import 'package:tracker/loginScreen.dart';
import 'package:tracker/notification.dart';
import 'package:tracker/onBoardScreen.dart';
import 'package:tracker/parentLayout.dart';
import 'package:tracker/splash.dart';

import 'constant/component.dart';



DatabaseReference ref = FirebaseDatabase.instance.ref('aDYbtciai3XJS8NgKezvFN1SioI3');

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationService().showNotification(
      title:'arrived',
      body: 'your child is arrived'
  );
  Fluttertoast.showToast(msg: 'on background');
}


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


  dioHelper.init();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  // FirebaseMessaging.onMessage.listen((event){
  //   print('on message');
  //   print(event.data.toString());
  //
  //   Fluttertoast.showToast(msg: 'on message');
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event){
  //   print('on message open app');
  //   print(event.data.toString());
  //
  //   Fluttertoast.showToast(msg: 'on message open app');
  // });

  await NotificationService().initNotification();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  ID = CacheHelper.getData(key: 'ID');
  print(ID);


  ref.onValue.listen((event){


    dioHelper.postFCM(
        url: 'send',
        data: {
          'to' : 'eufC7hwTR824Kd_yYxLONa:APA91bHAQH0cd_hiMoa1CeR_BL1zSL755t86wi2ZjxH_cxU2plxAHQCr_Z3DU6sS0L9CFbgyTylxBWe4sPhD5wXHPeujvjSur1Czgnu687pm3oB-Y6LDm5cJBHl3t-yTUKqpqPtKRKl8'
        }
    );
  });





  getCurrentAddress();

  FlutterBackgroundService.initialize(onStart);

  runApp(MyApp());
}

String? change;

void onStart(){
  WidgetsFlutterBinding.ensureInitialized();



  ref.onValue.listen((event){


    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  });



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
      home: driverLayout(),

      // CacheHelper.getData(key: 'ID') == null ? splash() :
      //     CacheHelper.getData(key: 'visitor') == 'admin' ? adminLayout() :
      //     CacheHelper.getData(key: 'visitor') == 'parents' ? parentLayout() :
      //     CacheHelper.getData(key: 'visitor')== 'driver' ? driverLayout() :
      //         null,
      debugShowCheckedModeBanner: false,
    );
  }
}

