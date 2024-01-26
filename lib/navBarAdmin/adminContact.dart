
import 'package:flutter/material.dart';

import '../constant/component.dart';

class adminContact extends StatefulWidget {




  @override
  State<adminContact> createState() => _adminContactState();
}

class _adminContactState extends State<adminContact> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
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
        child: Row(
            children:
            [
              Expanded(
                child: Column(
                  children: [
                    const Text('Drivers'),
                    myDivider(),
                    const Text('driver name'),
                    const Text('01002819302' , style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    const Text('Students'),
                    myDivider(),
                    const Text('student name'),
                    const Text('01002819302' , style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}
