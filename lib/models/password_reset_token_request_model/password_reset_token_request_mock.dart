import 'package:padyatra/models/password_reset_token_request_model/password_reset_token_request_data.dart';

class MockPasswordResetTokenRequest
    implements PasswordResetTokenRequestRepository {
  @override
  Future<List<PasswordResetTokenRequest>> fetchServerResponse(String email) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <PasswordResetTokenRequest>[
  new PasswordResetTokenRequest(
    response: "token_sent",
    message: "password reset token sent to your@gmail.com",
  )
];
