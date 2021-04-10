import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/password_reset_token_request_model/password_reset_token_request_data.dart';

abstract class PasswordResetTokenRequestListViewContract {
  void onLoadComplete(List<PasswordResetTokenRequest> items);
  void onLoadError();
}

class PasswordResetTokenRequestListPresenter {
  PasswordResetTokenRequestListViewContract _viewContract;
  PasswordResetTokenRequestRepository _passwordResetTokenRequestRepository;

  PasswordResetTokenRequestListPresenter(this._viewContract) {
    _passwordResetTokenRequestRepository =
        new Injector().passwordResetTokenRequestRepository;
  }
  void loadServerResponse(String email) {
    _passwordResetTokenRequestRepository
        .fetchServerResponse(email)
        .then((sr) => _viewContract.onLoadComplete(sr))
        .catchError((onError) => _viewContract.onLoadError());
  }
}
