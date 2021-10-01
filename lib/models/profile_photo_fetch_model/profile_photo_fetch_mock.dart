import 'package:padyatra/models/profile_photo_fetch_model/profile_photo_fetch_data.dart';

class MockProfilePhoto implements ProfilePhotoRepository {
  @override
  Future<List<ProfilePhoto>> fetchPhotoData(String rememberToken) {
    return new Future.value(profilePhoto);
  }
}

var profilePhoto = <ProfilePhoto>[
  new ProfilePhoto(
    serverResponsMessage: "success",
    profilePhotoPath: "image.png",
  ),
];
