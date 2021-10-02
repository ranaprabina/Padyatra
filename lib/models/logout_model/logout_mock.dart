import 'package:padyatra/models/logout_model/logout_data.dart';

class MockLogout implements LogoutRepository {
  @override
  Future<List<Logout>> sendUserEmail(String email) {
    return new Future.value(logout);
  }
}

var logout = <Logout>[
  new Logout(
    serverResponsMessage: "success",
    message: "user successfully logged out",
  ),
];
