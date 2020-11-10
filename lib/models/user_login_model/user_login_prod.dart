import 'dart:convert';
import 'package:padyatra/models/user_login_model/user_login_data.dart';
import 'package:padyatra/services/api.dart';

class ProdUserLoginRepository implements UserLoginRepository {
  @override
  Future<List<UserLogin>> sendUserData(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };
    var response = await ApiCall().postData(data, 'login');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null && responseBody1 == null) {
      throw new FetchDataException1(
          "An Error Occured during user login process : [Status Code : $statusCode");
    }
    return responseBody1.map((sR) => new UserLogin.fromMap(sR)).toList();
  }
}
