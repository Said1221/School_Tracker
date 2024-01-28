import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/loginCubit/loginState.dart';

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
      print('success');
    }).catchError((error){
      emit(loginErrorState());
      print(error.toString());
    });
  }

}
