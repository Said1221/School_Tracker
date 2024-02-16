
import 'package:flutter/material.dart';

import '../constant/component.dart';
import '../constant/my_clipper.dart';
import '../parents/busTrack.dart';


class parentsHome extends StatelessWidget {
  const parentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF16826),
                              Color(0xFFC75833),
                            ]
                        )
                    )
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage('assets/parents.png'),
                radius: 40,
              ),
            ],
          ),
      
         SizedBox(
           height: 150,
         ),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('Follow the current location of your children' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
         ),

         SizedBox(
           height: 20,
         ),

         InkWell(
           onTap: () => navigateTo(context, busTrack()),
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
                   Image.asset('assets/pointer.png', scale: 8,),
                   SizedBox(width: 5,),
                   Text('Track'),
                 ],
               ),
             ),
           ),
         ),
      
        ],
      ),
    );
  }
}
