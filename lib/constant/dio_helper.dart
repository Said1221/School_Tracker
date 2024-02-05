import 'package:dio/dio.dart';

class dioHelper{
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
      )
    );
  }

  static Future<Response>postFCM({
    required String url,
    required Map<String , dynamic>data
})async{

    dio!.options.headers ={
      'Content-Type' : 'application/json',
      'Authorization' : 'key=AAAA97KNCVY:APA91bHGCrzvtiMRH3MINLcd1jXXgJ0qy9_vV-GqvJ3K2wJhDkbF2GuZuINvd0MzzsdBdvrOeKN7gujL84uDjLtC0ZVSandhtBT2fx619tfnioYIZc8FtVs8SHWVecGmg49SxFC4QAo1'
    };

    return await dio!.post(
      url,
      data: data,
    );
  }
}