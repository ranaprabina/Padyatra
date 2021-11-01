import 'dart:convert';

import 'package:padyatra/models/profile_photo_fetch_model/profile_photo_fetch_data.dart';
import 'package:padyatra/services/api.dart';

class ProdProfilePhotoRepository implements ProfilePhotoRepository {
  @override
  Future<List<ProfilePhoto>> fetchPhotoData(String rememberToken) async {
    var data = {'remember_token': rememberToken};
    var response = await ApiCall().postData(data, "imagePath");
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    print(responseBody1);
    final statusCode = response.statusCode;
    print(statusCode);

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException1(
          "An error occured during fetching photo path :[Status Code : $statusCode]");
    }
    return responseBody1.map((sR) => new ProfilePhoto.fromMap(sR)).toList();
  }
}
