import 'dart:convert';

import 'package:padyatra/models/password_reset_token_request_model/password_reset_token_request_data.dart';
import 'package:padyatra/services/api.dart';

class ProdPasswordResetTokenRequestRepository
    implements PasswordResetTokenRequestRepository {
  @override
  Future<List<PasswordResetTokenRequest>> fetchServerResponse(
      String email) async {
    var data = {
      'email': email,
    };
    print(data);
    var response = await ApiCall().postData(data, 'createResetToken');
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['serverResponse'];
    print("password reset token serverResponse\m");
    print(responseBody1);
    final statusCode = response.statusCode;
    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
        "An Error Occured : [Status Code : $statusCode]",
      );
    }
    return responseBody1
        .map((rd) => new PasswordResetTokenRequest.fromMap(rd))
        .toList();
  }
}
