import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/helper.dart';
import 'package:goturkishfoodapp/screens/auth/signup/signup.dart';
import 'package:goturkishfoodapp/screens/auth/signup/signup.dart';
import 'package:goturkishfoodapp/screens/auth/signup/signup2.dart';
import 'package:goturkishfoodapp/screens/routing_screen.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class LoginScreen extends StatefulWidget {
  static final id = "LoginPage";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Form ====================================================
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController _textFieldController_username;
  TextEditingController _textFieldController_password;
  String _password;
  String _username;

  bool hidePassword = true;
  bool showSpinner = false;

  Future<WooCustomer> loginUserLocal() async {
    log("loginUserLocal Called");
    final customer = WooCustomer(password: _password, username: _username);
    return customer;
  }

  Future<bool> loginUserServer() async {
    log("loginUserServer Called");

    setState(() {
      showSpinner = true;
    });
    var customer = await loginUserLocal();
    log(" local costumer :${customer.username}");

    // // WooCustomer customer;
    // try {
    //   var response = await WooCommerceApi.prodMode
    //       .authenticateViaJWT(
    //           username: customer.username, password: customer.password)
    //       .then((value) async{
    //
    //        print( " TOKEN : $value");
    //       if (value is String) {
    //         // int id = await WooCommerceApi.prodMode.fetchLoggedInUserId();
    //         var headers = {
    //           'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYmFscWVzLmNvbSIsImlhdCI6MTYxMzE5MTQxMywibmJmIjoxNjEzMTkxNDEzLCJleHAiOjE2MTM3OTYyMTMsImRhdGEiOnsidXNlciI6eyJpZCI6IjEifX19.AbVEPH2YjpJO11Z0s5Q1UgW2LrMm1Bzx3j33dg3IqYQ',
    //           'Cookie': '__cfduid=d08ce4ed5e593e84b1a73756ed5bec1551613280759'
    //         };
    //
    //         var id = await http.get("https://balqes.com/wp-json/wc/v3/customers/50",headers:headers );
    //         var res = await json.decode(id.body);
    //           var wj = WooCustomer.fromJson(res);
    //          var id1 = wj.id;
    //
    //         print("res: ${res}");
    //
    //         var customer1 = await WooCommerceApi.prodMode.getCustomerById(id: id1);
    //         print("Name: ${customer1.username}");

    // }
    //   });
    //   // _printToLog('attempted token : '+ response.toString());
    //   // print("${response}");
    //
    // //   if (response is String) {
    // //     int id = await WooCommerceApi.prodMode.fetchLoggedInUserId();
    // //     customer = await WooCommerceApi.prodMode.getCustomerById(id: id);
    // //   }
    // //   return customer;
    // } catch (e) {
    //   setState(() {
    //     showSpinner = false;
    //   });
    //   return e.message;
    // }
    

    final login =
        await WooCommerceApi().loginUser(_username, _password).then((value) {
         
         
      if (value != null) {
        print(value.toString());
        return true;
      } else {
      
        return false;
      }
    }).catchError((e) {
      print(e);
    }).whenComplete(() => setState(() {
              showSpinner = false;
            }));
    return login;
  }


  @override
  void initState() {
    super.initState();
    _textFieldController_password = TextEditingController();
    _textFieldController_username = TextEditingController();

    this._password = _textFieldController_password.text;
    this._username = _textFieldController_username.text;
  }

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
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                
                                  keyboardType: TextInputType.name,
                                  onSaved: (input) => _username = input,
                                  validator: (input) => input.isEmpty ? "Check" : null,
                                  decoration: new InputDecoration(
                                    // hintText: "إيميل",
                                    labelText: 'Username',

                                    // counterStyle: textStyleCardStock,
                                    // hintStyle: textStyleCardStock,
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
                              ),
                              SizedBox(height: 20),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                 
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _password = input,
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
                              FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                                onPressed: () async {
                                  var isOk = await validateAndSave();
                                  if (isOk) {
                                   
                                  var sonuc =  WooCommerceApi().loginUser(_username, _password);
                                   
                                   
                                    if (sonuc != null) {
                                      return Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => RoutingScreen(),
                                        ),
                                      );
                                    } else {
                                      
                                      print(sonuc.toString());
                                    }
                                  } else {
                                    print("Somthing Wrong!!");
                                  }
                                },
                                child: Text(
                                  "Login",
                                  
                                ),
                                color: Colors.orange,
                                shape: StadiumBorder(),
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
    _textFieldController_username.clear();
    _textFieldController_password.clear();
  }
}
