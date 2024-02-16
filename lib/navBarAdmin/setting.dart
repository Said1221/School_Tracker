
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/cache_helper.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/splash.dart';

import '../constant/my_clipper.dart';
import '../regCubit/regAdminModel.dart';

class setting extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
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
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      CacheHelper.getData(key: 'visitor') == 'admin' ? AssetImage('assets/admin.png') :
                      CacheHelper.getData(key: 'visitor') == 'parents' ? AssetImage('assets/parents.png') :
                      CacheHelper.getData(key: 'visitor') == 'driver' ? AssetImage('assets/driver.png') :
                      null
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(settingName , style: TextStyle(fontSize:30 ,color: Colors.white),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(settingEmail, style: TextStyle(fontSize:15 , color: Colors.white),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(settingPhone , style: TextStyle(fontSize:15 , color: Colors.white),),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red
                      ),
                      child: MaterialButton(onPressed: (){
                        CacheHelper.removeData(key: 'ID');
                          Fluttertoast.showToast(
                            msg: 'You have successfully logged out',
                            timeInSecForIosWeb: 3,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: 16,
                            backgroundColor: Colors.red,
                          );
                          navigateTo(context, splash());
                      },
                      child: const Text('Logout' , style: TextStyle(fontSize:15 , color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
