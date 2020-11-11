import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserLoggedIn = false;
  String userId;
  @override
  void initState() {
    _checkIfUserIsLoggedIn();
    super.initState();
  }

  void _checkIfUserIsLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        var userJson = localStorage.getString('user');
        var user = jsonDecode(userJson);
        userId = user['userId'].toString();
        _isUserLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padyatra',
      debugShowCheckedModeBanner: false,
      home: _isUserLoggedIn
          ? HomePage(
              userId: userId,
            )
          : SplashScreen(),
      routes: {},
    );
  }
}
