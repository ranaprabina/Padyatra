import 'dart:convert';

import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';
import 'package:http/http.dart' as http;

class ProdInsertUserInterestRouteCategoryRepository
    implements InsertUserInterestRouteCategoryRepository {
  String insertUserInterestRouteCategoryUrl =
      "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/insertUserInterest.php";
  // "http://192.168.1.65/PHP%20codes/Padyatra/API's/insertUserInterest.php";

  @override
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName, String userId) async {
    // throw UnimplementedError();
    http.Response response =
        await http.post(insertUserInterestRouteCategoryUrl, body: {
      "category_name": categoryName,
      "user_id": userId,
    });
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    print(responseBody1);

    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException1(
          "An error occured during inserting user interes route category : [Status Code : $statusCode");
    }
    return responseBody1
        .map((sR) => new InsertUserInterestRouteCategory.fromMap(sR))
        .toList();
  }
}
