import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:padyatra/models/user_login_model/user_login_data.dart';

class ProdUserLoginRepository implements UserLoginRepository {
  String sendUserLoginDataUrl =
      "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/userLogin.php";
  // "http://192.168.1.65/PHP%20codes/Padyatra/API's/userLogin.php";

  @override
  Future<List<UserLogin>> sendUserData(String email, String password) async {
    http.Response response = await http.post(sendUserLoginDataUrl, body: {
      "email": email,
      "password": password,
    });
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException1(
          "An Error Occured during user login process : [Status Code : $statusCode");
    }
    return responseBody1.map((sR) => new UserLogin.fromMap(sR)).toList();
  }
}
