import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/auth/login/login2.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:woocommerce/models/customer.dart';

import '../../../helper.dart';

class SignUpPage extends StatefulWidget {
  static final id = "SignUpPage";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Form ====================================================
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController _textFieldController_fname;
  TextEditingController _textFieldController_lname;
  TextEditingController _textFieldController_email;
  TextEditingController _textFieldController_username;
  TextEditingController _textFieldController_password;

  String _fname;
  String _lname;
  String _email;
  String _password;
  String _username;

  bool hidePassword = true;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _textFieldController_fname = TextEditingController();
    _textFieldController_lname = TextEditingController();
    _textFieldController_email = TextEditingController();
    _textFieldController_password = TextEditingController();
    _textFieldController_username = TextEditingController();
    this._fname = _textFieldController_fname.text;
    this._lname = _textFieldController_lname.text;
    this._email = _textFieldController_email.text;
    this._password = _textFieldController_password.text;
    this._username = _textFieldController_username.text;
  }

  Future<WooCustomer> createdNewCustomerFromInput() async {
    log("createdNewCustomerFromInput Called");
    final customer =
        WooCustomer(firstName: _fname, lastName: _lname, email: _email, password: _password, username: _username);
    return customer;
  }

  Future<bool> createdNewCustomerInServer() async {
    final customer = await createdNewCustomerFromInput();
    setState(() {
      showSpinner = true;
    });

    final rigesterd = await WooCommerceApi().createCustumer(customer).whenComplete(() {
      setState(() {
        showSpinner = false;
      });

      // return Scaffold.of(context).showSnackBar(snackBar);
    }).then((value) {
      if (value == true) {
      

        // Fluttertoast.showToast(
        //     msg: "  ${customer.firstName } تم إنشاء الحساب",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        // clearForm();
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      }
    }).catchError((e) {
      // Fluttertoast.showToast(
      //     msg: "$e",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    });

    return rigesterd;
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
              onTap: (){},
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
                          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 10), blurRadius: 20)],
                        ),
                        child: Form(
                          key: globalFormKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text(
                              "Register" ,
                                
                              ),
                              SizedBox(height: 20),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  controller: _textFieldController_fname,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                  
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) {
                                    return _fname = input;
                                  },
                                  // validator: (input) {
                                  //   var name = customer.firstName = input;
                                  //   print(name);
                                  //   return name;
                                  // },
                                  // obscureText: hidePassword,
                                  decoration: new InputDecoration(
                                    labelText: "First Name",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                    prefixIcon: Icon(
                                      Icons.receipt,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  controller: _textFieldController_lname,

                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _lname = input,
                                  // validator: (input) =>
                                  // input.length < 3 ? "Password should be more than 3 characters" : null,
                                  // obscureText: hidePassword,
                                  decoration: new InputDecoration(
                                    labelText: "Lastname",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                    prefixIcon: Icon(
                                      Icons.receipt,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  controller: _textFieldController_email,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                              
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (input) => _email = input,
                                  validator: (input) => !input.contains('@') ? "Email Id should be valid" : null,
                                  decoration: new InputDecoration(
                                    // hintText: "إيميل",
                                    labelText: 'E-mail',

                                    // counterStyle: textStyleCardStock,
                                    // hintStyle: textStyleCardStock,
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  controller: _textFieldController_username,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                 
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _username = input,
                                  validator: (input) =>
                                      input.length < 3 ? "User should be more than 3 characters" : null,
                                  decoration: new InputDecoration(
                                    labelText: "Username",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: new TextFormField(
                                  controller: _textFieldController_password,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                 
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _password = input,
                                  validator: (input) =>
                                      input.length < 3 ? "Password should be more than 3 characters" : null,
                                  obscureText: hidePassword,
                                  decoration: new InputDecoration(
                                    labelText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
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
                                      color: Colors.orange.withOpacity(0.4),
                                      icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                child: Text(
                                  " I have account ",
                                 
                                ),
                                onTap: () {
                                  return Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => LoginScreen(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 30),
                              TextButton(
                                onPressed: () async {
                                  var isOk = await validateAndSave();

                                  if (isOk) {
                                    final customer = await createdNewCustomerInServer();
                                    if (customer is WooCustomer) {
                                      print(customer);
                                      return Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => LoginScreen(),
                                        ),
                                      );
                                    } else if (customer is WooCustomer) {
                                      print("customer");
                                    }
                                    print(customer);
                                  } else {
                                    print(" Wrong  Inputs!!");
                                  }
                                },
                                child: Text(
                                  "Register",
                               
                                ),
                              
                              ),
                              SizedBox(height: 15),
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
    _textFieldController_email.clear();
    _textFieldController_fname.clear();
    _textFieldController_lname.clear();
  }
}
