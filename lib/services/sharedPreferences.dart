import 'package:shared_preferences/shared_preferences.dart';

class HoldUserData {
  var token;
  var user;

  holdUserData(var token, var user) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    this.token = localStorage.setString('token', token);
    this.user = localStorage.setString('user', user);
  }
}
