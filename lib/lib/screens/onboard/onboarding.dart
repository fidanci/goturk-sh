import 'package:flutter/material.dart';
import '../auth/login/authPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: PageView(
                children: [
                  Image.asset(
                    "images/support.png",
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    "images/turkish.png",
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    "images/delivery.png",
                    fit: BoxFit.contain,
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => AuthPage()),
                          (route) => false);
                    },
                    child: Text("Continue")),
              ))
        ],
      ),
    );
  }
}
