import 'package:padyatra/models/user_login_model/user_login_data.dart';

class MockUserLogin implements UserLoginRepository {
  @override
  Future<List<UserLogin>> sendUserData(String email, String password) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <UserLogin>[
  new UserLogin(
    serverResponseMessage: "login_success",
    userId: '5',
    email: "hari@gmail.com",
    name: "Hari",
    token: 'asdasgdfg34456sdgdr6r67regdr56e56',
  )
];
