
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/state.dart';
import 'navBarAdmin/adminContact.dart';
import 'navBarAdmin/adminHome.dart';
import 'navBarAdmin/adminTrack.dart';
import 'navBarAdmin/setting.dart';
import 'navBarDriver/driverContacts.dart';
import 'navBarDriver/driverHome.dart';
import 'navBarParents/parentsContacts.dart';
import 'navBarParents/parentsHome.dart';




class AppCubit extends Cubit<AppState>{
  AppCubit() : super (AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget>screens = [
     adminHome(),
     adminTrack(),
     adminContact(),
     setting()
  ];

  List<Widget>screens2 = [
     parentsHome(),
     parentsContact(),
     setting()
  ];

  List<Widget>screens3 = [
     driverHome(),
     driverContact(),
     setting()
  ];

  void changeNav(int index){
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

}