class UserSignUp {
  String serverResponseMessage;
  String userId;
  String email;
  String name;
  String message;
  String token;

  UserSignUp({
    this.serverResponseMessage,
    this.userId,
    this.email,
    this.name,
    this.message,
    this.token,
  });

  UserSignUp.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'],
        userId = map['userId'].toString(),
        email = map['email'],
        name = map['name'],
        message = map['message'],
        token = map['token'];
}

abstract class UserSignUpRepository {
  Future<List<UserSignUp>> sendNewUserData(
      String name, String email, String password);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
