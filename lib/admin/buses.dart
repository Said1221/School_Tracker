
import 'package:flutter/material.dart';

class buses extends StatelessWidget {

  var busNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
        child: Card(
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
                  child: Row(
                    children: [
                      const Expanded(child: Text('bus number')),
                      IconButton(onPressed: (){},
                          icon: Image.asset('assets/tracking.png', color: Colors.red,scale: 20,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        show(context);
      },
        elevation: 20,
        backgroundColor: Colors.white,
        child: const Text('+',style: TextStyle(color: Colors.black , fontSize: 30),),
      ),
    );
  }

  show(BuildContext context){
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
        TextButton(onPressed: (){}, child: const Text('save'))
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
