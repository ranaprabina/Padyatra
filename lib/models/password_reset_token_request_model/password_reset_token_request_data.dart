import 'dart:async';

class PasswordResetTokenRequest {
  String response;
  String message;
  PasswordResetTokenRequest({
    this.response,
    this.message,
  });
  PasswordResetTokenRequest.fromMap(Map<String, dynamic> map)
      : response = map['Response'],
        message = map['message'];
}

abstract class PasswordResetTokenRequestRepository {
  Future<List<PasswordResetTokenRequest>> fetchServerResponse(String email);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
