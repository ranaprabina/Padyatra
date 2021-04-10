import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/password_reset_model/password_reset_data.dart';

abstract class PasswordResetListViewContract {
  void onLoadComplete(List<PasswordReset> items);
  void onLoadError();
}

class PasswordResetListPresenter {
  PasswordResetListViewContract _viewContract;
  PasswordResetRepository _passwordResetRepository;

  PasswordResetListPresenter(this._viewContract) {
    _passwordResetRepository = new Injector().passwordResetRepository;
  }
  void loadServerResponse(String password, String token) {
    _passwordResetRepository
        .fetchServerResponse(password, token)
        .then((sr) => _viewContract.onLoadComplete(sr))
        .catchError((onError) => _viewContract.onLoadError());
  }
}
