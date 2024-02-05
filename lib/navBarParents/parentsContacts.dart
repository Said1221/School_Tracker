
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
      create: (BuildContext)=>AppCubit()..getParentsContact(),
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
                child: state is AppGetParentsContactSuccessState ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
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
                                backgroundImage: AssetImage('assets/user.png'),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                                backgroundImage: AssetImage('assets/user.png'),
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
                                  backgroundImage: AssetImage('assets/user.png'),
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
