
import 'package:flutter/material.dart';

import '../constant/component.dart';
import '../constant/my_clipper.dart';
import '../drivers/driverTrack.dart';


class driverHome extends StatelessWidget {
  const driverHome({Key? key}) : super(key: key);

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
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF3383CD),
                            Color(0xFF11249F),
                          ]
                      )
                  )
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: const AssetImage('assets/user.png'),
              radius: 40,
            ),
          ],
        ),

        const SizedBox(
          height: 150,
        ),

        InkWell(
          onTap: () => navigateTo(context, const driverTrack()),
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
                  Image.asset('assets/finish-flag.png', scale: 8,),
                  const SizedBox(width: 5,),
                  const Text('Start the trip'),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
