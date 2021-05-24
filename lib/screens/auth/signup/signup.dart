import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/auth/validator.dart';
import 'package:goturkishfoodapp/screens/routing_screen.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';
import 'package:woocommerce/woocommerce.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   final _formKey = GlobalKey<FormState>();
   String name;
  String username;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
              "https://goturkishfood.com/wp-content/uploads/2019/11/GoTurkishFoodLogo.png"),
          Container(
            height: size.height / 1.5,
            width: size.width,
            margin: EdgeInsets.all(size.height / 40),
            padding: EdgeInsets.all(size.height / 60),

            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightGreen,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0.5, 1),
                  )
                ],
                shape: BoxShape.rectangle,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.height / 25))),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    TextFormField(
                      validator: (String value) {
                        if(value.length > 3){
                          return null;
                        } else return "Name pls";
                      },
                    onSaved: (String value){
                      name = value;
                    },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.height / 30)),
                              borderSide:
                                  BorderSide(color: Colors.orangeAccent)),
                          labelText: "Full Name"),
                    ),
                  TextFormField(
                    validator: (String value){
                      if(value.length > 6){
                        return null;
                      }else{
                        return "Min 6 char";
                      }
                    },
                    onSaved: (String value){
                      username = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height / 30)),
                            borderSide:
                                BorderSide(color: Colors.orangeAccent)),
                        labelText: "Username"),
                  ),
                  TextFormField(
                    validator: (String input) =>
                        input.isValidEmail() ? null : "Check Email",
                        onSaved: (String value) => email = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height / 30)),
                            borderSide:
                                BorderSide(color: Colors.orangeAccent)),
                        labelText: "E-mail"),
                  ),
                  TextFormField(
                    validator: (String input) =>
                        input.isValidPass() ? null : "Check Password",
                        onSaved: (String value) => password = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height / 30)),
                            borderSide:
                                BorderSide(color: Colors.orangeAccent)),
                        labelText: "Password"),
                  ),
                
                  FloatingActionButton.extended(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          try {
                            var user = WooCustomer(firstName: name,email: email,password: password,username: username);
                            var sonuc = WooCommerceApi().createCustumer(user);
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RoutingScreen()));
                          } catch (e) {
                            print(e.toString());
                          }
                          _formKey.currentState.reset();




                        
                        
                        }
                      }, label: Text("Register "))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
