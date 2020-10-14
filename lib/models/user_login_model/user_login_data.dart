class UserLogin {
  String serverResponseMessage;
  String userId;
  String firstName;
  String email;
  String lastName;

  UserLogin({
    this.serverResponseMessage,
    this.userId,
    this.firstName,
    this.email,
    this.lastName,
  });

  UserLogin.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'],
        userId = map['userId'],
        email = map['email'],
        firstName = map['firstName'],
        lastName = map['lastName'];
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
