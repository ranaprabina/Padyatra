import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:padyatra/services/api_constants.dart';

class ApiCall {
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  postData(data, apiUrl) async {
    String fullUrl = ApiConstants().baseURL + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  postMultipartRequest(profilePhotoPath, rememberToken, apiUrl) async {
    String fullUrl = ApiConstants().baseURL + apiUrl;
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    request.files.add(await http.MultipartFile.fromPath(
        'profile_photo_path', profilePhotoPath));
    request.fields['remember_token'] = rememberToken;
    return await request.send();
  }

  getData(apiUrl) async {
    String fullUrl = ApiConstants().baseURL + apiUrl;
    return await http.get(fullUrl, headers: _setHeaders());
  }
}
