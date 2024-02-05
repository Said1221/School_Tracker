
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tracker/constant/component.dart';
import 'package:tracker/loginScreen.dart';
import 'package:tracker/onBoardScreen.dart';

import 'constant/my_clipper.dart';


class onBoardingModel{
String image;
String title;
String info;

onBoardingModel({
  required this.image,
  required this.title,
  required this.info,
});
}

class splash extends StatefulWidget {

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  
  var borderController = PageController();
  var last;

  List<onBoardingModel>boarding = [

    onBoardingModel(
      image : 'assets/board.jpg',
      title: 'Welcome',
      info: 'If you register as a school\'s administrator , please ensure you register in your '
          'school location',
    ),

    onBoardingModel(
      image : 'assets/1.jpg',
      title: 'Register as a Parent',
      info: 'If you register as a Parent , please be sure to register in the '
          'location where your child lives',
    ),

    onBoardingModel(
      image : 'assets/2.jpg',
      title: 'Register as a Driver',
      info: 'If you are driver , you should login into your account using your email address '
          'and your mobile phone , it\'s added by the school administrator'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFF16826),
                      Color(0xFFC75833),
                    ],
                  ),
                ),
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                          onPageChanged: (int index){
                          if(index == boarding.length-1){

                              setState((){
                                last = 'last';
                              });

                           }
                          else{
                            setState((){
                              last = '';
                            });
                          }
                          },
                          controller: borderController,
                          itemBuilder: (context , index)=> buildOnBoarding(boarding[index]),
                        itemCount: boarding.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 30 , right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: SmoothPageIndicator(
                                controller: borderController,
                                count: boarding.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: Colors.orange,
                                dotColor: Colors.orange,
                                dotHeight: 10,
                                expansionFactor: 4,
                                dotWidth: 10,
                                spacing: 5,
                              ),
                            ),
                          ),
                          FloatingActionButton(onPressed: (){
                            borderController.nextPage(
                                duration: Duration(
                                  microseconds: 750,
                                ),
                                curve: Curves.bounceInOut
                            );
                            if(last == 'last'){
                              navigateTo(context, onBoarding());
                            }
                          },
                            backgroundColor: Colors.orange,
                          child: last == 'last' ? Icon(Icons.login) : Icon(Icons.navigate_next),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(onBoardingModel model)=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30 , left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.orange),),
            SizedBox(
              height: 5,
            ),
            Text(model.info , style: TextStyle(fontSize: 15 , color: Colors.grey),),
          ],
        ),
      ),
    ],
  );
}
