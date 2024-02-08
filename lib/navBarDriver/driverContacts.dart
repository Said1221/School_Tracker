
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';

import '../state.dart';

class driverContact extends StatefulWidget {




  @override
  State<driverContact> createState() => _driverContactState();
}

class _driverContactState extends State<driverContact> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getDriverContact(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Contact' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: state is AppGetDriverContactSuccessState ?
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      Text('School details' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/admin.png'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(schoolName.toString() , style: TextStyle(fontSize: 20),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(schoolEmail.toString()),
                              Text(schoolPhone.toString() , style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Students on this bus' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context , index)=>Card(
                              elevation: 10,
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('assets/students.png'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(contactsName[index].toString(), style: TextStyle(fontSize: 20),),
                                    Text(contactsAddress[index].toString()),
                                    Text(contactsPhone[index].toString() , style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: contactsName.length,
                        ),
                      ),
                    ]
                ) :
                Center(child: CircularProgressIndicator(color: Colors.blue,))
              ),
            ),
          );
          },
      ),
    );
  }
}
