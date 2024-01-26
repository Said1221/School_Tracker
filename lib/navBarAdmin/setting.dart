
import 'package:flutter/material.dart';

import '../constant/my_clipper.dart';

class setting extends StatelessWidget {


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
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/user.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Ahmed Mohamed' , style: TextStyle(fontSize:30 ,color: Colors.white),),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('said@gmail.com' , style: TextStyle(fontSize:15 , color: Colors.white),),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('01002819302' , style: TextStyle(fontSize:15 , color: Colors.white),),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red
                    ),
                    child: MaterialButton(onPressed: (){},
                    child: const Text('Logout' , style: TextStyle(fontSize:15 , color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
