import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/loginCubit/loginState.dart';

import '../constant/component.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit () : super (loginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  void loginUser({
    required String email,
    required String password,
}){
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      emit(loginSuccessState());
      ID = value.user?.uid;
      print(ID);
      CacheHelper.saveData(key: 'ID', value: ID);
    }).catchError((error){
      emit(loginErrorState());
      print(error.toString());
    });
  }

}
