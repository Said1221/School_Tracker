
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/cubit.dart';

import '../constant/component.dart';
import '../state.dart';

class adminContact extends StatefulWidget {

  @override
  State<adminContact> createState() => _adminContactState();
}

class _adminContactState extends State<adminContact> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getStudent()..getDriver(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Contact' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state is AppGetStudentSuccessState || state is AppGetDriverSuccessState ?
              Row(
                  children:
                  [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Drivers'),
                          myDivider(),
                           Expanded(
                             child: ListView.separated(
                                 itemBuilder: (context , index)=>Column(
                                   children: [
                                     Text(driverDetails[index]['name']),
                                     Text(driverDetails[index]['phone'] , style: TextStyle(color: Colors.grey),),
                                   ],
                                 ),
                                 separatorBuilder: (Context , index)=>myDivider(),
                                 itemCount: driverDetails.length,
                             ),
                           ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                           Text('Students'),
                          myDivider(),
                           Expanded(
                             child: ListView.separated(
                                 itemBuilder: (context , index)=>Column(
                                   children: [
                                     Text(studentDetails[index]['name']),
                                     Text(studentDetails[index]['parentsPhone'] , style: TextStyle(color: Colors.grey),),
                                   ],
                                 ),
                                 separatorBuilder: (context , index)=>myDivider(),
                                 itemCount: studentDetails.length,
                             ),
                           ),
                        ],
                      ),
                    ),
                  ]
              ) :
              Center(child: CircularProgressIndicator(color: Colors.blue,))
            ),
          );
          },
      ),
    );
  }
}
