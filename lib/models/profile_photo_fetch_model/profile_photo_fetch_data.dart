class ProfilePhoto {
  String serverResponsMessage;
  String profilePhotoPath;

  ProfilePhoto({
    this.serverResponsMessage,
    this.profilePhotoPath,
  });

  ProfilePhoto.fromMap(Map<String, dynamic> map)
      : serverResponsMessage = map['Response'],
        profilePhotoPath = map['profile_photo_path'];
}

abstract class ProfilePhotoRepository {
  Future<List<ProfilePhoto>> fetchPhotoData(String rememberToken);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
