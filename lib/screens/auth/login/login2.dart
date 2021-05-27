
import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/service/data/sharedPref.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


import '../../../helper.dart';
import '../../../service/data/woocommerce.dart';
import '../../routing_screen.dart';
import '../signup/signup2.dart';

class LoginScreen extends StatefulWidget {
  static final id = "LoginPage";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String password;
  String username;

  bool hidePassword = true;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
   
 
    return ModalProgressHUD(
      color: Colors.white,
      progressIndicator: spinkit,
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, offset: Offset(0, 10), blurRadius: 20)
                          ],
                        ),
                        child: Form(
                          key: globalFormKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text(
                                " Login ",
                              
                              ),
                              SizedBox(height: 20),
                             
                              
                        TextFormField(
                                 
                                  textInputAction: TextInputAction.next,
                                
                                  keyboardType: TextInputType.name,
                                  onSaved: (input) => username = input,
                                  validator: (input) => input.isEmpty ? "Check" : null,
                                  decoration: new InputDecoration(
                                  
                                    labelText: 'Username',

                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green)),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              
                              SizedBox(height: 20),
                                 TextFormField(
                                 
                                  textInputAction: TextInputAction.next,
                                 
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => password = input,
                                  validator: (input) => input.length < 3
                                      ? "Password should be more than 3 characters"
                                      : null,
                                  obscureText: hidePassword,
                                  decoration: new InputDecoration(
                                    labelText:"Password",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green)),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.orange,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      color: Colors.green.withOpacity(0.4),
                                      icon: Icon(
                                          hidePassword ? Icons.visibility_off : Icons.visibility),
                                    ),
                                  ),
                                ),
                        
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "Forgot Password",
                                       
                                      ),
                                      onTap: ()  {
                                     /*   await launchForgetPassworddWebView(
                                            context, forgetPasswordUrl); */
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Register",
                                     
                                      ),
                                      onTap: () async {
                                        return Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => SignUpPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                             TextButton (
                              
                                onPressed: () async {
                                  var isOk = await validateAndSave();
                                  if (isOk) {
                                     WooCommerceApi().loginUserCustom(username: "yeniyeni",password: "yeniyeni").then((value) => 
                                     value.isNotEmpty ? SharedPref().saveToken(value): print("hata")
                                     
                                     ).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=>RoutingScreen())));
                                  
                                 
                             
                                  } else {
                                    print("Somthing Wrong!!");
                                    
                                 
                                  }
                                },
                                child: Text(
                                  "Login",
                                  
                                ),
                                
                              ),
                              SizedBox(height: 30),
                          
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validateAndSave() async {
    await Future.delayed(Duration(seconds: 0));

    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void clearForm() {
    globalFormKey.currentState.reset();
   
  }
}
