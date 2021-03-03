import 'dart:convert';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';
import 'package:padyatra/services/api.dart';

class ProdInsertUserInterestRouteCategoryRepository
    implements InsertUserInterestRouteCategoryRepository {
  @override
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName, String userId) async {
    var data = {
      'categoryName': categoryName,
      'userId': userId,
    };
    var response =
        await ApiCall().postData(data, 'trekkingRoutes/insertUserInterest');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    print(responseBody1);

    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null && responseBody1 == null) {
      throw new FetchDataException1(
          "An error occured during inserting user interes route category : [Status Code : $statusCode");
    }
    return responseBody1
        .map((sR) => new InsertUserInterestRouteCategory.fromMap(sR))
        .toList();
  }
}
