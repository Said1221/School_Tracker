
import 'package:flutter/material.dart';

class students extends StatelessWidget {

  var studentNameController = TextEditingController();
  var studentAddressController = TextEditingController();
  var parentPhoneController = TextEditingController();
  var studentClassController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students'),
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('student name')),
                          Text('class 2' , style: TextStyle(color: Colors.green),),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('parents phone num' , style: TextStyle(color: Colors.grey),)
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
