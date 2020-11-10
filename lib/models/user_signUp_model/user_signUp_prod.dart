import 'dart:convert';

import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';
import 'package:http/http.dart' as http;

class ProdUserSignUpRepository implements UserSignUpRepository {
  String senduserSignUpDataUrl =
      // "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/userSignUp.php";
      "http://192.168.1.65/PHP%20codes/Padyatra/API's/userSignUp.php";

  @override
  Future<List<UserSignUp>> sendNewUserData(
      String firstName, String lastName, String email, String password) async {
    http.Response response = await http.post(senduserSignUpDataUrl, body: {
      "firstName": firstName,
      "middleName": "",
      "lastName": lastName,
      "email": email,
      "password": password,
    });

    final responseBody = jsonDecode(response.body);
    print(responseBody);

    final List responseBody1 = responseBody['serverResponse'];
    print(responseBody1);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException1(
          "Error Occured during sign up process : [Status Code : $statusCode] ");
    }

    return responseBody1.map((sR) => new UserSignUp.fromMap(sR)).toList();
  }
}
