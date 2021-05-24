import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/auth/login/login2.dart';
import 'package:goturkishfoodapp/screens/auth/signup/signup2.dart';
import 'package:goturkishfoodapp/screens/routing_screen.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';
import 'package:goturkishfoodapp/service/provider/provider.dart';

import '../signup/signup.dart';
import 'login.dart';

class AuthPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
  var service = WooCommerceApi().checkLogged();
  if(service == true){
    return RoutingScreen();
  }else{
    return buildScaffold(context);
  }
}

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Go Turkish Food"),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("images/start.png"),
        Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
            
      
            width: 300,
            child: TextButton(child: Text("Login",style: TextStyle(color: Colors.white),), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }),),
        SizedBox(height:20),
        Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
            
      
            width: 300,
            child: TextButton(child: Text("Register",style: TextStyle(color: Colors.white)), onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

            }),),
          Divider(),
         
       
      ],
    ),
  );
  }
}
