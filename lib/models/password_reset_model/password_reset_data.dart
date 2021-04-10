class PasswordReset {
  String response;
  String message;
  PasswordReset({
    this.response,
    this.message,
  });
  PasswordReset.toMap(Map<String, dynamic> map)
      : response = map['Response'],
        message = map['message'];
}

abstract class PasswordResetRepository {
  Future<List<PasswordReset>> fetchServerResponse(
      String password, String token);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
