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

class HoldAppOpenedStatus {
  var status;
  holdAppOpenedStatus(bool status) async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    this.status = localStorage1.setBool("status", status);
  }
}

class DeleteUserData {
  deleteUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
  }
}

class DeleteAppOpenedStatus {
  deleteAppOpenedStatus() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    localStorage1.remove('status');
  }
}
