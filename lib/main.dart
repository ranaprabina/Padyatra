import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/MainPage.dart';
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
  bool _isAppAlreadyOpened = false;
  String userId;
  @override
  void initState() {
    _checkIfUserIsLoggedIn();
    _checkAppOpenedStatus();
    super.initState();
  }

  void _checkAppOpenedStatus() async {
    SharedPreferences locaStorage1 = await SharedPreferences.getInstance();
    var status = locaStorage1.getBool('status');
    print("app opened status is :");
    print(status);
    if (status == true) {
      setState(() {
        _isAppAlreadyOpened = true;
      });
    } else {
      setState(() {
        _isAppAlreadyOpened = false;
      });
    }
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
          : _isAppAlreadyOpened
              ? GuestUser()
              : SplashScreen(),
      routes: {},
    );
  }
}
