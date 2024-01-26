import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/regCubit/regAdminModel.dart';
import 'package:tracker/regCubit/regParentsModel.dart';
import 'package:tracker/regCubit/regState.dart';

class RegCubit extends Cubit<RegState>{
  RegCubit() : super (regInitialState());

  static RegCubit get(context)=>BlocProvider.of(context);

  void adminReg({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String location,
}){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      createAdmin(
          name: name,
          email: email,
          phone: phone,
          location: location,
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
    required String location,
    required String UID,

}){
    regAdminModel model =regAdminModel(
        name: name,
        email: email,
        phone: phone,
        location: location,
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
    required String location,
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
          location: location,
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
    required String location,
    required String UID,
}){

    regParentsModel model =regParentsModel(
      name: name,
      email: email,
      schoolEmail: schoolEmail,
      phone: phone,
      location: location,
      UID: UID,
    );

    FirebaseFirestore.instance.collection('users').doc('G9NCYqrtmndR7w3tgaY3kPasqjw2').
    collection('parents').doc(UID).set(model.toMap());
  }

}