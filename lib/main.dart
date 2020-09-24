import 'package:flutter/material.dart';
import 'package:padyatra/dependency_injector/dependency_injection.dart';

import 'package:padyatra/screen/OnBoardingScreen.dart';
import 'package:padyatra/screen/SplashScreen.dart';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padyatra',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {},
    );
  }
}
