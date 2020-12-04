import 'dart:convert';

import 'package:padyatra/models/completed_route_model/completed_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdCompletedRouteRepository implements CompletedRouteRepository {
  @override
  Future<List<CompletedRoute>> fetchCompletedRoutes(String userId) async {
    var data = {
      'id': userId,
    };
    var response = await ApiCall().postData(data, 'completedRoutes');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error occured: [Status Code : $statusCode]");
    }
    return responseBody1.map((cr) => new CompletedRoute.toMap(cr)).toList();
  }
}
