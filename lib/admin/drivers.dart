
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';

import '../state.dart';

class drivers extends StatefulWidget {


  @override
  State<drivers> createState() => _driversState();
}

class _driversState extends State<drivers> {

  var driverNameController = TextEditingController();
  var driverAddressController = TextEditingController();
  var driverEmailController = TextEditingController();
  var driverPhoneController = TextEditingController();
  var driverBusController = TextEditingController();
  String? bus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){

          if(state is AppGetDriverSuccessState){
            Fluttertoast.showToast(
              msg: 'driver added successfully',
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );
          }

          if(state is AppGetDriverErrorState){
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.red,
            );
          }

        },
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(

            appBar: AppBar(title: const Text('Drivers' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
              titleSpacing: 0,
            ),

            body: Padding(
              padding:  EdgeInsets.all(8.0),
              child: state is! AppGetDataInitialState ?
              ListView.separated(
              itemBuilder: (context , index)=>Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: const AssetImage('assets/driver.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(driverDetails[index]['name']),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(driverDetails[index]['phone'] , style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/bus.png' , scale: 20,),
                                Text(driverDetails[index]['bus'] , style: TextStyle(color: Colors.green),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context , index)=>myDivider(),
              itemCount: driverDetails.length,
            ) :
              Center(child: CircularProgressIndicator(color: Colors.blue,)),
            ),

            floatingActionButton: FloatingActionButton(onPressed: (){

              AlertDialog alert = AlertDialog(
                scrollable: true,
                title: const Text('add new driver'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextFormField(
                      controller: driverNameController,
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
                      controller: driverEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('email address',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.email,
                            color: Colors.black,
                          )
                      ),
                    ),
                    TextFormField(
                      controller: driverPhoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('phone',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.phone,
                            color: Colors.black,
                          )
                      ),
                    ),

                    TextFormField(
                      controller: driverAddressController,
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
                            Icons.home,
                            color: Colors.black,
                          )
                      ),
                    ),
                    
                    DropdownButton(
                        hint: const Text('select bus'),
                        value: bus,
                        items: [
                          for(int i=busNumbers.length-1 ; i>=0 ; i--)
                            busNumbers[i]['busNum'].toString()

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
                    cubit.addDriver(
                      name: driverNameController.text,
                      email: driverEmailController.text,
                      phone: driverPhoneController.text,
                      address: driverAddressController.text,
                      bus: bus.toString(),
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
