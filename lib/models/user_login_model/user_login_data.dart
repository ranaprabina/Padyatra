class UserLogin {
  String serverResponseMessage;
  String userId;
  String name;
  String email;
  String token;

  UserLogin({
    this.serverResponseMessage,
    this.userId,
    this.name,
    this.email,
    this.token,
  });

  UserLogin.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'],
        userId = map['userId'].toString(),
        email = map['email'],
        name = map['name'],
        token = map['token'];
}

abstract class UserLoginRepository {
  Future<List<UserLogin>> sendUserData(String email, String password);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
