import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/profile_photo_fetch_model/profile_photo_fetch_data.dart';

abstract class ProfilePhotoListViewContract {
  void onProfilePhotoUploadComplete(List<ProfilePhoto> items);
  void onProfilePhotoUploadError();
}

class ProfilePhotoListPresenter {
  ProfilePhotoListViewContract _viewContract;
  ProfilePhotoRepository _profilePhotoRepository;

  ProfilePhotoListPresenter(this._viewContract) {
    _profilePhotoRepository = new Injector().profilePhotoRepository;
  }

  void loadServerResponse(String rememberToken) {
    _profilePhotoRepository
        .fetchPhotoData(rememberToken)
        .then((sR) => _viewContract.onProfilePhotoUploadComplete(sR))
        .catchError((onError) => _viewContract.onProfilePhotoUploadError());
  }
}
