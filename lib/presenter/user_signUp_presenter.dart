import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';

abstract class UserSignUpListViewContract {
  void onUserSignUpComplete(List<UserSignUp> items);
  void onUserSignUpError();
}

class UserSignUpListPresenter {
  UserSignUpListViewContract _viewContract;
  UserSignUpRepository _repository;

  UserSignUpListPresenter(this._viewContract) {
    _repository = new Injector().userSignUpRepository;
  }

  void loadServerResponse(
      String firstName, String lastName, String email, String password) {
    _repository
        .sendNewUserData(firstName, lastName, email, password)
        .then((sR) => _viewContract.onUserSignUpComplete(sR))
        .catchError((onError) => _viewContract.onUserSignUpError());
  }
}
