import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Image.network("https://image.freepik.com/free-vector/no-internet-connection-sign_79145-136.jpg"),
    ),
      
    );
  }
}