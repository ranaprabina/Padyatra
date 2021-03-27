import 'dart:convert';

import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/services/api.dart';

class ProdRouteDetailsRepository implements RouteDetailsRepository {
  @override
  Future<List<RouteDetails>> fetchRouteDetails(
      String selectedRouteName, String userId) async {
    var data = {
      'routeName': selectedRouteName,
      'u_id': userId,
    };
    var response =
        await ApiCall().postData(data, 'trekkingRoutes/routeDetails');
    final responseBody = jsonDecode(response.body);
    print(response);
    final List respnseBody1 = responseBody['selectedRoute'];
    final List respnseBody2 = responseBody['documnets'];
    // final List responseResult = [respnseBody1, respnseBody2];
    // print(responseResult);
    print(respnseBody1.length);
    print(respnseBody1);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
        "An Error Occured : [Status Code : $statusCode]",
      );
    }
    return respnseBody1.map((rd) => new RouteDetails.toMap(rd)).toList();
  }
}
