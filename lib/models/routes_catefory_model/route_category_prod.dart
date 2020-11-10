import 'dart:convert';

import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:http/http.dart' as http;

class ProdRouteCategoryRepository implements RouteCategoryRepository {
  String fetchRouteCategory =
      // "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/selectCategoryName.php";
      "http://192.168.1.65/PHP%20codes/Padyatra/API's/selectCategoryName.php";

  @override
  Future<List<RouteCategory>> fetchRouteCategories() async {
    http.Response response = await http.get(fetchRouteCategory);
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
