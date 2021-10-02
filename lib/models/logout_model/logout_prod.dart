import 'dart:convert';
import 'package:padyatra/models/logout_model/logout_data.dart';
import 'package:padyatra/services/api.dart';

class ProdLogoutRepository implements LogoutRepository {
  @override
  Future<List<Logout>> sendUserEmail(String email) async {
    var data = {'email': email};
    var response = await ApiCall().postData(data, "logout");
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException1(
          "An error occured during  logout :[Status Code : $statusCode]");
    }
    return responseBody1.map((sR) => new Logout.fromMap(sR)).toList();
  }
}
