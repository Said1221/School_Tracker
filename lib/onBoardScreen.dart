
import 'package:flutter/material.dart';
import 'package:tracker/loginScreen.dart';

import 'constant/component.dart';
import 'constant/my_clipper.dart';


class onBoarding extends StatelessWidget {


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
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: (){
                      visitor = 'admin';
                      navigateTo(context, loginScreen());
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey[300]
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/admin.png',scale: 8,),
                              const SizedBox(width: 5,),
                              const Text('I am Admin'),
                            ],
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  InkWell(
                    onTap: (){
                      visitor = 'parents';
                      navigateTo(context, loginScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/parents.png',scale: 8,),
                            const SizedBox(width: 5,),
                            const Text('I am Parent'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  InkWell(
                    onTap: (){
                      visitor = 'driver';
                      navigateTo(context, loginScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/driver.png',scale: 8,),
                            const SizedBox(width: 5,),
                            const Text('I am Driver'),
                          ],
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
