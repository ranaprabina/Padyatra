import 'package:padyatra/models/password_reset_model/password_reset_data.dart';

class MockPasswordReset implements PasswordResetRepository {
  @override
  Future<List<PasswordReset>> fetchServerResponse(
      String password, String token) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <PasswordReset>[
  new PasswordReset(
    response: "Password_Reset_Success",
    message: "Successfully reset password",
  )
];
