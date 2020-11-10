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

  getData(apiUrl) async {
    String fullUrl = ApiConstants().baseURL + apiUrl;
    return await http.get(fullUrl, headers: _setHeaders());
  }
}
