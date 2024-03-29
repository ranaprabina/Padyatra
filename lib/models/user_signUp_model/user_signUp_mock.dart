import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';

class MockUserSignUp implements UserSignUpRepository {
  @override
  Future<List<UserSignUp>> sendNewUserData(
      String name, String email, String password) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <UserSignUp>[
  new UserSignUp(
    serverResponseMessage: "new_user_inserted_successfully",
    userId: '2',
    email: "test@test.com",
    name: "test",
    message: "The email was already taken",
    token: "Doe",
  )
];
