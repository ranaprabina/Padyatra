import 'dart:convert';

import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';
import 'package:padyatra/services/api.dart';
import 'package:padyatra/services/sharedPreferences.dart';

class ProdUserSignUpRepository implements UserSignUpRepository {
  @override
  Future<List<UserSignUp>> sendNewUserData(
      String name, String email, String password) async {
    var data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var response = await ApiCall().postData(data, 'register');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    var token = responseBody['token'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null && responseBody1 == null) {
      throw new FetchDataException1(
          "Error Occured during sign up process : [Status Code : $statusCode] ");
    }

    HoldUserData().holdUserData(token, jsonEncode(responseBody1[0]));

    return responseBody1.map((sR) => new UserSignUp.fromMap(sR)).toList();
  }
}
