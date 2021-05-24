import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';

import '../../helper.dart';
import '../routing_screen.dart';

class SplashScreen extends StatefulWidget {
  static final id = "SplashPage";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   
    super.initState();
    Timer(Duration(seconds: 5),()=>goToHomePage());
  }

 
  goToHomePage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoutingScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          SizedBox(height: 20,),
          Image.network("https://goturkishfood.com/wp-content/uploads/2019/11/GoTurkishFoodLogo.png"),
           SizedBox(height: 30,),
           spinkit,
        ],
      ),
      
    );
  }
}