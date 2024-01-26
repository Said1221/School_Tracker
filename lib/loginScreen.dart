
import 'package:flutter/material.dart';
import 'package:tracker/parentLayout.dart';
import 'package:tracker/adminRegisterScreen.dart';
import 'package:tracker/parentsRegisterScreen.dart';

import 'adminLayout.dart';
import 'constant/component.dart';
import 'constant/my_clipper.dart';
import 'driverLayout.dart';


class loginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
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
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey
                      ),
                      child: MaterialButton(onPressed: (){
                        if(visitor == 'admin'){
                          navigateTo(context,  adminLayout());
                        }

                        else if(visitor == 'parents'){
                          navigateTo(context,  parentLayout());
                        }

                        else{
                          navigateTo(context,  driverLayout());
                        }

                      },
                        child: const Text("Login",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),

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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
