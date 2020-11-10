import 'dart:convert';

import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:padyatra/services/api.dart';

class ProdRouteCategoryRepository implements RouteCategoryRepository {
  @override
  Future<List<RouteCategory>> fetchRouteCategories() async {
    var response = await ApiCall().getData('getCategory');
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['Category Name'];
    print(responseBody1);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException(
          "An error occured during fetching route category : [Status Code : $statusCode]");
    }
    return responseBody1.map((rc) => new RouteCategory.fromMap(rc)).toList();
  }
}
