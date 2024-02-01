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
    required String latitude,
    required String longitude,
}){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      createAdmin(
          name: name,
          email: email,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          UID: value.user!.uid,
      );
    }).catchError((error){
      emit(regAdminErrorState());
    });
  }

  void createAdmin({
    required String name,
    required String email,
    required String phone,
    required String latitude,
    required String longitude,
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
          emit(regAdminCreatUserSuccessState());
          print(UID);
          print('success');
        }).catchError((error){
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
    required String latitude,
    required String longitude,
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
      emit(regParentsErrorState());
      print(error.toString());
    });
  }
  
  void createParents({
    required String name,
    required String email,
    required String schoolEmail,
    required String phone,
    required String latitude,
    required String longitude,
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

          FirebaseFirestore.instance.collection('users').doc(ID2).
          collection('parents').doc(UID).set(model.toMap());
        }
        else{
          print('this school not found');
        }
      });
    });
  }

}