
import 'package:flutter/material.dart';
import '../admin/buses.dart';
import '../admin/drivers.dart';
import '../admin/students.dart';
import '../constant/component.dart';
import '../constant/my_clipper.dart';

class adminHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                    height: 200,
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
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: const AssetImage('assets/admin.png'),
                radius: 40,
              ),
            ],
          ),

          SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: ()=>navigateTo(context, buses()),
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
                              Image.asset('assets/bus.png',scale: 8,),
                              const SizedBox(width: 5,),
                              const Text('Buses'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=>navigateTo(context,  drivers()),
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
                              const Text('Drivers'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 25,
          ),

          InkWell(
            onTap: ()=>navigateTo(context, students()),
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
                    Image.asset('assets/students.png',scale: 8,),
                    const SizedBox(width: 5,),
                    const Text('Students'),
                  ],
                ),
              ),
            ),
          ),

        ],
      );
  }
}
