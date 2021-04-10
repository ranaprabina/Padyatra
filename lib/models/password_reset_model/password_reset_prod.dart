import 'dart:convert';

import 'package:padyatra/models/password_reset_model/password_reset_data.dart';
import 'package:padyatra/services/api.dart';

class ProdPasswordResetRepository implements PasswordResetRepository {
  @override
  Future<List<PasswordReset>> fetchServerResponse(
      String password, String token) async {
    var data = {
      'password': password,
      'token': token,
    };
    var response = await ApiCall().postData(data, 'resetPassword');
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;
    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
        "An Error Occured : [Status Code : $statusCode]",
      );
    }
    return responseBody1.map((rd) => new PasswordReset.toMap(rd)).toList();
  }
}
