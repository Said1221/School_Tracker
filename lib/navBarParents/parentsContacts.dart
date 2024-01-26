
import 'package:flutter/material.dart';

class parentsContact extends StatefulWidget {




  @override
  State<parentsContact> createState() => _parentsContactState();
}

class _parentsContactState extends State<parentsContact> {

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
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
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
                            Text('School name' , style: TextStyle(fontSize: 20),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('School administrator'),
                            Text('01002819302' , style: TextStyle(color: Colors.grey),),
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
                            Text('Driver' , style: TextStyle(fontSize: 20),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('driver name'),
                            Text('01002819302' , style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ]
            ),
          ),
        ),
      ),
    );
  }
}
