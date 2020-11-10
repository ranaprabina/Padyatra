import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/search_route_model/search_route_data.dart';

import 'package:padyatra/services/api.dart';

class ProdSearchRouteRepsitory implements SearchRouteRepository {
  @override
  Future<List<SearchRoute>> fetchRoutes() async {
    var response = await ApiCall().getData('trekkingRoutes');
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['Routes'];
    print(responseBody1);

    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException(
          "An error occured : [Status Code : $statusCode");
    }
    return responseBody1.map((sr) => new SearchRoute.fromMap(sr)).toList();
  }
}
