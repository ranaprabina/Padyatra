class UserSignUp {
  String serverResponseMessage;
  String userId;
  String email;
  String firstName;
  String middleName;
  String lastName;

  UserSignUp({
    this.serverResponseMessage,
    this.userId,
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
  });

  UserSignUp.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'],
        userId = map['userId'],
        email = map['email'],
        firstName = map['firstName'],
        middleName = map['middleName'],
        lastName = map['lastName'];
}

abstract class UserSignUpRepository {
  Future<List<UserSignUp>> sendNewUserData(
      String firstName, String lastName, String email, String password);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
