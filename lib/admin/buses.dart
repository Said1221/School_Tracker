
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/admin/busLocation.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';
import 'package:tracker/state.dart';

class buses extends StatefulWidget {

  @override
  State<buses> createState() => _busesState();
}

class _busesState extends State<buses> {
  var busNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){

          if(state is AppGetBusSuccessState){
            Fluttertoast.showToast(
              msg: 'bus added successfully',
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );
          }

          if(state is AppGetBusErrorState){
            Fluttertoast.showToast(
              msg: 'bus number must be not empty',
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
            appBar: AppBar(title: const Text('Buses' , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
              titleSpacing: 0,
            ),

            body: Padding(
              padding: const EdgeInsets.all(8.0),

              child: state is! AppGetDataInitialState ?
              GridView.count(crossAxisCount: 2,
                children: List.generate(busNumbers.length, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: AssetImage('assets/bus.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: Text(busNumbers[index]['busNum'])),
                                IconButton(onPressed: (){
                                  navigateTo(context, busLocation(index));
                                },
                                    icon: Image.asset('assets/tracking.png', color: Colors.green,scale: 20,)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ),
              ) :
                  Center(child: CircularProgressIndicator(color: Colors.blue,)),
            ),

            floatingActionButton: FloatingActionButton(onPressed: (){

              AlertDialog alert = AlertDialog(
                scrollable: true,
                title: const Text('add new bus'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextFormField(
                      controller: busNumberController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      validator: (value){
                        return null;

                        // if(value.isEmpty){
                        //   return 'please enter your email address';
                        // }
                      },
                      decoration: const InputDecoration(
                          label: Text('bus number',style: TextStyle(color: Colors.black),),
                          prefixIcon:Icon(
                            Icons.numbers,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: (){
                    cubit.addBus(
                        busNum: busNumberController.text,
                    );

                  }, child: Text('save'))
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
