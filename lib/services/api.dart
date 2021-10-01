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
    // var res = await request.send();
    // final statusCode = res.statusCode;
    // print("res statusCode is");
    // print(res.statusCode);
    // print(res.reasonPhrase);
    return await request.send();
    // return await http.post(fullUrl,
    //     headers: {'Content-type': "multipart/form-data"},
    //     body: jsonEncode(data),
    //     //     {
    //     //   "lang": "fas",
    //     //   "image": data["profile_photo_path"],
    //     //   "remember_token": data["remember_token"]
    //     // },
    //     encoding: Encoding.getByName("utf-8"));
  }

  getData(apiUrl) async {
    String fullUrl = ApiConstants().baseURL + apiUrl;
    return await http.get(fullUrl, headers: _setHeaders());
  }
}
