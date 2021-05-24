import 'package:flutter/material.dart';

import '../../../service/data/woocommerce.dart';
import '../../routing_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  WooCommerceApi service = WooCommerceApi();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
            margin: EdgeInsets.all(size.height / 30),
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.length > 0) {
                          return null;
                        } else
                          return "check";
                      },
                      onSaved: (value) => username = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.height / 30)),
                              borderSide:
                                  BorderSide(color: Colors.orangeAccent)),
                          labelText: "Username"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String value) =>
                          value.length > 0 ? null : "check",
                      onSaved: (value) => password = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.height / 30)),
                              borderSide:
                                  BorderSide(color: Colors.orangeAccent)),
                          labelText: "Password"),
                    ),
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          try {
                            service.loginUser(username, password).whenComplete(
                                () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RoutingScreen())));
                          } catch (e) {
                            print(e.toString());
                            scaffoldKey.currentState.showBottomSheet(
                                (context) => Text(e.toString()));
                          }
                        }
                      },
                      label: Text("Login "))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
