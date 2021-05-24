import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/routing_screen.dart';

import 'screens/onboard/onboarding.dart';
import 'screens/other/other.dart';
import 'thema.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go Turkish Food',
      theme: myTheme,
      home: OnBoardingPage(),
    );
  }
}

