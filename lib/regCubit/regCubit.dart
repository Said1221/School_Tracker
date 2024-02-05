import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/regCubit/regAdminModel.dart';
import 'package:tracker/regCubit/regParentsModel.dart';
import 'package:tracker/regCubit/regState.dart';

import '../constant/component.dart';

class RegCubit extends Cubit<RegState>{
  RegCubit() : super (regInitialState());

  static RegCubit get(context)=>BlocProvider.of(context);

  void adminReg({
    required String name,
    required String email,
    required String phone,
    required String password,
    required double latitude,
    required double longitude,
}){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      emit(regAdminCreatUserSuccessState());
      createAdmin(
          name: name,
          email: email,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          UID: value.user!.uid,
      );
    }).catchError((error){
      message2 = error.toString();
      emit(regAdminErrorState());
    });
  }

  void createAdmin({
    required String name,
    required String email,
    required String phone,
    required double latitude,
    required double longitude,
    required String UID,

}){
    regAdminModel model =regAdminModel(
        name: name,
        email: email,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        UID: UID,
    );

    FirebaseFirestore.instance.collection('users').doc(UID).set(model.toMap())
        .then((value){
          // emit(regAdminCreatUserSuccessState());
          print(UID);
          print('success');
        }).catchError((error){
          message2 = error.toString();
          emit(regAdminCreatUserErrorState());
          print(error.toString());
    });

  }


  void parentsReg({
    required String name,
    required String email,
    required String schoolEmail,
    required String phone,
    required String password,
    required double latitude,
    required double longitude,
}){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      createParents(
          name: name,
          email: email,
          schoolEmail: schoolEmail,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          UID: value.user!.uid,
      );
    }).catchError((error){
      message2 = error.toString();
      emit(regParentsErrorState());
      print(error.toString());
    });
  }
  
  void createParents({
    required String name,
    required String email,
    required String schoolEmail,
    required String phone,
    required double latitude,
    required double longitude,
    required String UID,
}){

    regParentsModel model =regParentsModel(
      name: name,
      email: email,
      schoolEmail: schoolEmail,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
      UID: UID,
    );
    
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element){
        if (element.data()['email'] == schoolEmail){
          ID2 = element.data()['UID'];
          
          FirebaseFirestore.instance.collection('users').doc(ID2)
          .collection('STUDENT').doc(phone).update({
            'latitude' : latitude,
            'longitude' : longitude,
          });

          FirebaseFirestore.instance.collection('users').doc(ID2).
          collection('parents').doc(UID).set(model.toMap()).then((value){
            emit(regParentsCreatUserSuccessState());
          });
        }
        else if(element.data()['email'] != schoolEmail){
          message2 = 'this school not found';
          emit(regParentsCreatUserErrorState());
        }

      });
    }).catchError((error){
      message2 = error.toString();
      emit(regParentsCreatUserErrorState());
    });
  }

}