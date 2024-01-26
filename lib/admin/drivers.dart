
import 'package:flutter/material.dart';

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
    return Scaffold(

      appBar: AppBar(title: const Text('Drivers'),
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
                          Expanded(child: Text('driver name')),
                          Text('bus number' , style: TextStyle(color: Colors.green),),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('driver phone num' , style: TextStyle(color: Colors.grey),)
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
                  Icons.location_pin,
                  color: Colors.black,
                )
            ),
          ),
          DropdownButton(
            hint: const Text('select bus'),
              value: bus,
              items: ['201', '458', '700', '100']
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
