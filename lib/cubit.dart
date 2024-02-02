

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/cache_helper.dart';
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

    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
        .get().then((value){
      schoolLat = value['latitude'];
      schoolLong = value['longtude'];

      FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
          .collection('BUS').doc(busNum).set({
        'busNum' : busNum,
        'latitude' : schoolLat,
        'longtude' : schoolLong,
          }).then((value){
        print('added');
      }).catchError((error){
        print('error');
      });

    });
  }

  void getBus(){
    lat.clear();
    long.clear();
    busNumbers.clear();
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
        .collection('BUS').get().then((value){
          value.docs.forEach((element){
            busNumbers.add(element.data());
            for(int x=busNumbers.length-1 ; x>=0 ; x--){
              dropButton.add(busNumbers[x]['busNum']);
              lat.add(busNumbers[x]['latitude']);
              long.add(busNumbers[x]['longtude']);
            }
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

      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: phone,
      ).then((value){
        FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
            .collection('DRIVER').doc(phone).set({
          'name' : name,
          'email' : email,
          'phone' : phone,
          'address' : address,
          'bus' : bus,
          'UID' : value.user?.uid,
        }).catchError((error){
          print(error.toString());
        });
      });


  }

  void getDriver(){
    driverDetails.clear();
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
        .collection('DRIVER').get().then((value){
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
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
        .collection('STUDENT').doc(parentsPhone).set({
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
    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'ID'))
        .collection('STUDENT').get().then((value){
      value.docs.forEach((element){
        studentDetails.add(element.data());
      });
      emit(AppGetStudentSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }

  void getParentsContact(){

    contactsName.clear();
    contactsClass.clear();

    FirebaseFirestore.instance.collection('users').get()
    .then((value){
      value.docs.forEach((element){
        FirebaseFirestore.instance.collection('users').doc(element.data()['UID']).collection('parents')
            .get().then((value){
          value.docs.forEach((element){
            if(element.data()['UID'] == CacheHelper.getData(key: 'ID')){
              parentContact = element.data()['schoolEmail'];
              parentContact2 = element.data()['phone'];



              FirebaseFirestore.instance.collection('users').get()
                  .then((value){
                value.docs.forEach((element){
                  if(parentContact == element.data()['email']){
                    schoolName = element.data()['name'].toString();
                    schoolEmail = element.data()['email'].toString();
                    schoolPhone = element.data()['phone'].toString();
                    adminUID = element.data()['UID'];
                    schoolLocationLati = element.data()['latitude'];
                    schoolLocationLong = element.data()['longtude'];


                    print(schoolLocationLati);
                    print(schoolLocationLong);
                    print(adminUID);
                    print(parentContact2);

                    FirebaseFirestore.instance.collection('users').doc(adminUID)
                    .collection('STUDENT').get().then((value){
                      value.docs.forEach((element){
                        if(parentContact2 == element.data()['parentsPhone']){
                          parentContact3 = element.data()['bus'];

                          contactsName.add(element.data()['name']);
                          contactsClass.add(element.data()['studentClass']);

                          FirebaseFirestore.instance.collection('users').doc(adminUID).
                              collection('BUS').doc(parentContact3).get().then((value){
                                busLocationLati = value['latitude'];
                                busLocationLong = value['longtude'];

                                print(busLocationLati);
                                print(busLocationLong);
                          });

                          print(parentContact3);

                          FirebaseFirestore.instance.collection('users').doc(adminUID).
                          collection('DRIVER').get().then((value){
                            value.docs.forEach((element){
                              if(parentContact3 == element.data()['bus']){
                                driverName = element.data()['name'];
                                driverEmail = element.data()['email'];
                                driverPhone = element.data()['phone'];

                                print(driverName);
                                print(driverEmail);
                                print(driverPhone);
                                emit(AppGetParentsContactSuccessState());
                              }
                            });
                          });
                        }
                      });
                    });
                  }

                });
              });
            }
          });

        }).catchError((error){
          print(error.toString());
          emit(AppGetParentsContactErrorState());
        });


      });
    });


  }

  void getDriverContact(){
    var ID;
    var bus;
    contactsName.clear();
    contactsAddress.clear();
    contactsPhone.clear();
    contactsPhone.clear();
    contactLatitude.clear();
    contactLongtude.clear();

    FirebaseFirestore.instance.collection('users')
        .get().then((value){
          value.docs.forEach((element){
            ID = element.data()['UID'];
            FirebaseFirestore.instance.collection('users').doc(ID).collection('DRIVER')
            .get().then((value){
              value.docs.forEach((element){
                if(element.data()['UID'] == CacheHelper.getData(key: 'ID')){
                  FirebaseFirestore.instance.collection('users')
                      .get().then((value){
                        value.docs.forEach((element){
                          schoolName = element.data()['name'];
                          schoolEmail = element.data()['email'];
                          schoolPhone = element.data()['phone'];
                          schoolLat = element.data()['latitude'];
                          schoolLong = element.data()['longtude'];

                          busLat = element.data()['latitude'];
                          busLong = element.data()['longtude'];


                          print(schoolName);
                          print(schoolEmail);
                          print(schoolPhone);
                          print(schoolLat);
                          print(schoolLong);
                        });
                  });

                  bus = element.data()['bus'];
                  FirebaseFirestore.instance.collection('users').doc(ID)
                  .collection('STUDENT').get().then((value){
                    value.docs.forEach((element){
                      if(element.data()['bus'] == bus){
                        contactsName.add(element.data()['name']);
                        contactsAddress.add(element.data()['address']);
                        contactsPhone.add(element.data()['parentsPhone']);
                        contactLatitude.add(element.data()['latitude']);
                        contactLongtude.add(element.data()['longitude']);

                        print(contactsName);
                        print(contactsAddress);
                        print(contactsPhone);
                        print(contactLatitude);
                        print(contactLongtude);
                      }
                    });
                    emit(AppGetDriverContactSuccessState());
                  }).catchError((error){
                    emit(AppGetDriverContactErrorState());
                    print(error.toString());
                  });

                }
              });
            });
          });
    });
  }

  
}