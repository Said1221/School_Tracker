
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';

import '../state.dart';

class parentsContact extends StatefulWidget {

  @override
  State<parentsContact> createState() => _parentsContactState();
}

class _parentsContactState extends State<parentsContact> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          return Scaffold(
            appBar: AppBar(
              title:  Text('Contact' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
            ),
            body:  Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: state is! AppGetDataInitialState ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(schoolPhone , style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text('your children\'s driver' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/driver.png'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(driverName.toString() , style: TextStyle(fontSize: 20),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(driverEmail.toString()),
                              Text(driverPhone.toString() , style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text('your childrens' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
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
                                Text(contactsClass[index].toString()),
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
                Center(child: CircularProgressIndicator(color: Colors.blue))
              ),
            ),
          );
          },
      ),
    );
  }
}
