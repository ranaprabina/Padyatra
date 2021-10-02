import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/logout_model/logout_data.dart';

abstract class LogoutListViewContract {
  void onLogoutComplete(List<Logout> items);
  void onLogoutError();
}

class LogoutListPresenter {
  LogoutListViewContract _viewContract;
  LogoutRepository _logoutRepository;

  LogoutListPresenter(this._viewContract) {
    _logoutRepository = new Injector().logoutRepository;
  }

  void loadServerResponse(String email) {
    _logoutRepository
        .sendUserEmail(email)
        .then((sR) => _viewContract.onLogoutComplete(sR))
        .catchError((onError) => _viewContract.onLogoutError());
  }
}
