
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/cubit.dart';
import 'package:tracker/state.dart';

class buses extends StatelessWidget {

  var busNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getBus(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Buses'),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                        ]
                    )
                ),
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(8.0),

              child: state is AppGetBusSuccessState ?
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
                            backgroundImage: const AssetImage('assets/user.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: Text(busNumbers[index]['busNum'])),
                                IconButton(onPressed: (){

                                },
                                    icon: Image.asset('assets/tracking.png', color: Colors.red,scale: 20,)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context , index)=>myDivider(),
                  itemCount: busNumbers.length
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
                  }, child: const Text('save'))
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
