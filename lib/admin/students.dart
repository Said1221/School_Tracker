
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';

import '../state.dart';

class students extends StatefulWidget {

  @override
  State<students> createState() => _studentsState();
}

class _studentsState extends State<students> {
  var studentNameController = TextEditingController();

  var studentAddressController = TextEditingController();

  var parentPhoneController = TextEditingController();

  var studentClassController = TextEditingController();

  String? bus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getStudent(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Students' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
              titleSpacing: 0,
            ),

            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: state is AppGetStudentSuccessState ?
              ListView.separated(
                itemBuilder: (Context , index)=>Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: const AssetImage('assets/user.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(studentDetails[index]['name'])),
                                  Text(studentDetails[index]['studentClass'] , style: TextStyle(color: Colors.green),),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(studentDetails[index]['parentsPhone'] , style: TextStyle(color: Colors.grey),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context , index)=>myDivider(),
                itemCount: studentDetails.length,
              ) :
              Center(child: CircularProgressIndicator(color: Colors.blue,)),

            ),
            floatingActionButton: FloatingActionButton(onPressed: (){

              AlertDialog alert = AlertDialog(
                scrollable: true,
                title: const Text('add new student'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextFormField(
                      controller: studentNameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('full name',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.black,
                          )
                      ),
                    ),
                    TextFormField(
                      controller: studentAddressController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('address',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.location_pin,
                            color: Colors.black,
                          )
                      ),
                    ),
                    TextFormField(
                      controller: parentPhoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('parents phone',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.phone,
                            color: Colors.black,
                          )
                      ),
                    ),
                    TextFormField(
                      controller: studentClassController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('student class',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.class_,
                            color: Colors.black,
                          )
                      ),
                    ),

                    DropdownButton(
                        hint: const Text('select bus'),
                        value: bus,
                        items: [
                          for(int x=busNumbers.length-1 ; x>=0 ; x--)
                            busNumbers[x]['busNum'].toString()
                        ]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),

                        onChanged: (String? value){
                          bus = value;
                          setState(() {
                            bus = value;
                          });

                        }
                    ),

                  ],
                ),
                actions: [
                  TextButton(onPressed: (){
                    cubit.addStudent(
                        name: studentNameController.text,
                        address: studentAddressController.text,
                        parentsPhone: parentPhoneController.text,
                        studentClass: studentClassController.text,
                        busNum:bus.toString(),
                    );
                  }
                  , child: const Text('save'))
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );

            },
              elevation: 20,
              backgroundColor: Colors.white,
              child: const Text('+',style: TextStyle(color: Colors.black , fontSize: 30),),
            ),
          );
          },
      ),
    );
  }
}
