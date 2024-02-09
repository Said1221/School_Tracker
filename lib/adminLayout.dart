
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/state.dart';

import 'cubit.dart';


class adminLayout extends StatefulWidget {


  @override
  State<adminLayout> createState() => _adminLayoutState();
}

class _adminLayoutState extends State<adminLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getAdminData()..getBus()..getDriver()..getStudent(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
                    ]
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.black,
                    onTap: (index){
                      cubit.changeNav(index);
                    },
                    currentIndex: cubit.currentIndex,
                    items: [
                      BottomNavigationBarItem(icon: Image.asset('assets/home.png',scale: 20,),
                          label: 'Home'
                      ),
                      BottomNavigationBarItem(icon: Image.asset('assets/tracking.png',scale: 20,),
                          label: 'Tracking'
                      ),
                      BottomNavigationBarItem(icon: Image.asset('assets/contact-book.png',scale: 20,),
                          label: 'Contact'
                      ),
                      BottomNavigationBarItem(icon: Image.asset('assets/settings.png',scale: 20,),
                          label: 'Setting'
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          },
      ),
    );
  }
}
