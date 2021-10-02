class Logout {
  String serverResponsMessage;
  String message;

  Logout({this.serverResponsMessage, this.message});

  Logout.fromMap(Map<String, dynamic> map)
      : serverResponsMessage = map['Response'],
        message = map['message'];
}

abstract class LogoutRepository {
  Future<List<Logout>> sendUserEmail(String email);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
