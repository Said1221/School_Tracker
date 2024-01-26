
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'constant/component.dart';
import 'constant/my_clipper.dart';
import 'loginScreen.dart';

class registerScreen extends StatelessWidget {

  var schoolNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var schoolLocation = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                              Color(0xFF3383CD),
                              Color(0xFF11249F),
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
                      controller: schoolNameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      validator: (value){
                        return null;
          
                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('School name',style: TextStyle(color: Colors.white),),
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
                    TextFormField(
                      controller: schoolLocation,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      validator: (value){
                        return null;
          
                        // if(value.isEmpty){
                        //   return 'please enter your password';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('School location',style: TextStyle(color: Colors.white),),
                          prefixIcon: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          )
                      ),
                    ),
          
                    const SizedBox(
                      height: 15,
                    ),
          
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey
                        ),
                        child: MaterialButton(onPressed: (){
          
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                          ).then((value){
                            print(value.toString());
                          }).catchError((error){
                            print(error.toString());
                          });
          
                          navigateTo(context, loginScreen());
                        },
                          child: const Text("Login",style: TextStyle(color: Colors.white),),
                        ),
                      ),
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
  }
}
