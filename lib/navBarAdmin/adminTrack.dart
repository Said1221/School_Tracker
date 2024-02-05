import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';


class adminTrack extends StatefulWidget {
  @override
  _adminTrackState createState() => _adminTrackState();
}

class _adminTrackState extends State<adminTrack> {
  final Completer<GoogleMapController> controller = Completer();

  late GoogleMapController googleMapController;

  // var _placeDistance;
  static LatLng sourceLocation = LatLng(
    CacheHelper.getData(key: 'latitude'),
    CacheHelper.getData(key: 'longitude') ,
  );



  //
  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }








  // LocationData? currentLocation;
  //
  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  // Uint8List? markerIcon;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;




  void setCustomMarkerIcon()async{
    BitmapDescriptor.hueBlue;

  //   destinationIcon = await BitmapDescriptor.fromAssetImage(
  //   ImageConfiguration(),
  // 'assets/bus.png',
  //   );


    // markerIcon = await getBytesFromAsset('assets/bus.png', 100);

  }

  @override
  void initState(){
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        
      
        body:
        Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(target: sourceLocation , zoom: 10.5),
                markers: {
      
                  Marker(
                    markerId:MarkerId('source'),
                    // icon: sourceIcon,
                    position:sourceLocation,
                  ),
      
                  for(int x = long.length-1 ; x>=0 ; x--)
                    Marker(
      
                      icon: destinationIcon,
                      markerId:MarkerId('destination'),
                      position:LatLng(lat[x] , long[x]),
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
                ],
              ),
            ),
          ],
        ),
      
      ),
    );

  }


}