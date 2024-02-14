import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/regCubit/regCubit.dart';
import 'package:tracker/regCubit/regState.dart';
import 'constant/component.dart';
import 'constant/my_clipper.dart';
import 'loginScreen.dart';

class parentsRegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var schoolEmailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var homeLocation = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>RegCubit(),
      child: BlocConsumer<RegCubit,RegState>(
        listener: (BuildContext context, RegState state){
          if(state is regParentsCreatUserSuccessState){
            Fluttertoast.showToast(
              msg: 'successfully registered',
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );
            navigateTo(context, loginScreen());
          }

          if(state is regParentsErrorState || state is regParentsCreatUserErrorState){
            Fluttertoast.showToast(
              msg: message2,
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (BuildContext context, RegState state){
          RegCubit cubit = RegCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
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
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.white),
                            validator: (value){
                              return null;

                              // if(value.isEmpty){
                              //   return 'please enter your email address';
                              // }
                            },
                            decoration: const InputDecoration(
                                label: Text('Name',style: TextStyle(color: Colors.white),),
                                prefixIcon:Icon(
                                  Icons.maps_home_work_rounded,
                                  color: Colors.white,
                                )
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            validator: (value){
                              return null;

                              // if(value.isEmpty){
                              //   return 'please enter your password';
                              // }
                            },
                            decoration: const InputDecoration(
                                label: Text('Email address',style: TextStyle(color: Colors.white),),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                )
                            ),
                          ),

                          TextFormField(
                            controller: schoolEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            validator: (value){
                              return null;

                              // if(value.isEmpty){
                              //   return 'please enter your password';
                              // }
                            },
                            decoration: const InputDecoration(
                                label: Text('School Email address',style: TextStyle(color: Colors.white),),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                )
                            ),
                          ),

                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            validator: (value){
                              return null;

                              // if(value.isEmpty){
                              //   return 'please enter your email address';
                              // }
                            },
                            decoration: const InputDecoration(
                                label: Text('Phone number',style: TextStyle(color: Colors.white),),
                                prefixIcon:Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                )
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: Colors.white),
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
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: state is! regParentsInitialState ?
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white
                              ),
                              child: MaterialButton(onPressed: (){
                                cubit.parentsReg(
                                  name: nameController.text,
                                  email: emailController.text,
                                  schoolEmail: schoolEmailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  latitude: CacheHelper.getData(key: 'latitude'),
                                  longitude: CacheHelper.getData(key: 'longitude'),
                                  token : token,
                                );
                              },
                                child: const Text("Register",style: TextStyle(color: Colors.black),),
                              ),
                            ) :
                                Center(child: CircularProgressIndicator(color: Colors.orange,))
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
