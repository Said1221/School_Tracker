

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/state.dart';
import 'navBarAdmin/adminContact.dart';
import 'navBarAdmin/adminHome.dart';
import 'navBarAdmin/adminTrack.dart';
import 'navBarAdmin/setting.dart';
import 'navBarDriver/driverContacts.dart';
import 'navBarDriver/driverHome.dart';
import 'navBarParents/parentsContacts.dart';
import 'navBarParents/parentsHome.dart';




class AppCubit extends Cubit<AppState>{
  AppCubit() : super (AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget>screens = [
     adminHome(),
     adminTrack(),
     adminContact(),
     setting()
  ];

  List<Widget>screens2 = [
     parentsHome(),
     parentsContact(),
     setting()
  ];

  List<Widget>screens3 = [
     driverHome(),
     driverContact(),
     setting()
  ];

  void changeNav(int index){
    currentIndex = index;
    emit(AppChangeNavBarState());
  }
  
  void addBus({
    required String busNum,
}){
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('BUS').doc(busNum).set({'busNum' : busNum})
        .then((value){
          print('added');
    }).catchError((error){
      print('error');
    });
  }

  void getBus(){
    busNumbers.clear();
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('BUS').get().then((value){
          value.docs.forEach((element){
            busNumbers.add(element.data());
          });
          emit(AppGetBusSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }


  void addDriver({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String bus,
  }){
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('Driver').doc(phone).set({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'address' : address,
      'bus' : bus,
        })
        .then((value){
      print('added');
    }).catchError((error){
      print('error');
    });
  }

  void getDriver(){
    driverDetails.clear();
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('Driver').get().then((value){
      value.docs.forEach((element){
        driverDetails.add(element.data());
      });
      emit(AppGetDriverSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }


  void addStudent({
    required String name,
    required String address,
    required String parentsPhone,
    required String studentClass,
    required String busNum,
  }){
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('Student').doc(parentsPhone).set({
      'name' : name,
      'address' : address,
      'parentsPhone' : parentsPhone,
      'studentClass' : studentClass,
      'bus' : busNum,
        })
        .then((value){
      print('added');
    }).catchError((error){
      print('error');
    });
  }

  void getStudent(){
    studentDetails.clear();
    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2')
        .collection('Student').get().then((value){
      value.docs.forEach((element){
        studentDetails.add(element.data());
      });
      emit(AppGetStudentSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }

  void getParentsContact(){
    FirebaseFirestore.instance.collection('users').get()
        .then((value){
          value.docs.forEach((element){
            if(element.data()['email'] == 'dfsd@gmail.com'){
              print(element.data()['name']);
            }
          });
    }).catchError((error){
      print(error.toString());
    });
  }
  
}