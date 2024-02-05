
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/loginCubit/loginCubit.dart';
import 'package:tracker/parentLayout.dart';
import 'package:tracker/adminRegisterScreen.dart';
import 'package:tracker/parentsRegisterScreen.dart';

import 'adminLayout.dart';
import 'constant/component.dart';
import 'constant/my_clipper.dart';
import 'driverLayout.dart';
import 'loginCubit/loginState.dart';


class loginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginState>(
        listener: (BuildContext context , LoginState state){

          if(state is loginSuccessState){
            Fluttertoast.showToast(
              msg: 'successfully registered',
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );
            if(visitor=='admin'){
              navigateTo(context, adminLayout());
            }
            if(visitor=='parents'){
              navigateTo(context, parentLayout());
            }
            if(visitor=='driver'){
              navigateTo(context, driverLayout());
            }
          }

          if(state is loginErrorState){
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.red,
            );
          }

        },
          builder: (BuildContext context , LoginState state){
          LoginCubit cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                        height: 700,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient:LinearGradient(
                                begin:Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors:[
                                  Color(0xFFF16826),
                                  Color(0xFFC75833),
                                ]
                            )
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          validator: (value){
                            return null;

                            // if(value.isEmpty){
                            //   return 'please enter your email address';
                            // }
                          },
                          decoration: const InputDecoration(
                              label: Text('Email Address',style: TextStyle(color: Colors.white),),
                              prefixIcon:Icon(
                                Icons.email,
                                color: Colors.white,
                              )
                          ),
                        ),
                        visitor != 'driver' ? TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          validator: (value){
                            return null;

                            // if(value.isEmpty){
                            //   return 'please enter your password';
                            // }
                          },
                          decoration: const InputDecoration(
                              label: Text('Password',style: TextStyle(color: Colors.white),),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              )
                          ),
                        )
                        : TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          validator: (value){
                            return null;

                            // if(value.isEmpty){
                            //   return 'please enter your password';
                            // }
                          },
                          decoration: const InputDecoration(
                              label: Text('Phone number',style: TextStyle(color: Colors.white),),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              )
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: state is! loginSuccessState ?
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: MaterialButton(onPressed: (){
                              visitor != 'driver' ? cubit.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                              ) : cubit.loginUser(
                                  email: emailController.text,
                                  password: phoneController.text
                              );
                            },
                              child: const Text("Login",style: TextStyle(color: Colors.black),),
                            ),
                          ) :
                              Center(child: CircularProgressIndicator(color: Colors.orange,))
                        ),

                        visitor !='driver'?
                        Center(
                          child: TextButton(onPressed: (){
                            if(visitor=='admin'){
                              navigateTo(context, adminRegisterScreen());
                            }

                            else{
                              navigateTo(context, parentsRegisterScreen());
                            }

                          },
                            child: Text('Create an account ?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ):
                            Text(''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          },
      ),
    );
  }
}
