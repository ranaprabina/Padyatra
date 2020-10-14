import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/user_login_model/user_login_data.dart';

abstract class UserLoginListViewContract {
  void onUserLoginComplete(List<UserLogin> items);
  void onUserLoginError();
}

class UserLoginListPresenter {
  UserLoginListViewContract _viewContract;
  UserLoginRepository _repository;

  UserLoginListPresenter(this._viewContract) {
    _repository = new Injector().userLoginRepository;
  }

  void loadServerResponse(String email, String password) {
    _repository
        .sendUserData(email, password)
        .then((sR) => _viewContract.onUserLoginComplete(sR))
        .catchError((onError) => _viewContract.onUserLoginError());
  }
}
