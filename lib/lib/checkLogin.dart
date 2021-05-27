import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'screens/auth/login/login2.dart';
import 'screens/routing_screen.dart';
import 'service/data/woocommerce.dart';

class CheckLogin extends StatefulWidget{
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  void initState() { 
    super.initState();
   // checkInternet();
    Timer(Duration(seconds: 3),()=>goToHomePage());
      }
/*
Future<void> checkInternet()async {
      var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.mobile ) {
 return goToHomePage();
  
} else if (connectivityResult == ConnectivityResult.none) {
  return NoInternet();
}
}*/
      @override
      Widget build(BuildContext context) {
     
       return Scaffold(
      body: Center(child: Image.network("https://goturkishfood.com/wp-content/uploads/2019/11/GoTurkishFoodLogo.png")),
      
    );
       
      }
    
      goToHomePage() async {
          var service = await WooCommerceApi().checkLogged();
         if(service){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoutingScreen()));
         }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
         }
    
      }
}