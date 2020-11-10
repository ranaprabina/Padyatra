import 'dart:convert';

import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:http/http.dart' as http;

class ProdRouteDetailsRepository implements RouteDetailsRepository {
  String routeDetailsURL =
      // "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/selectedRoute.php";
      "http://192.168.1.65/PHP%20codes/Padyatra/API's/selectedRoute.php";

  @override
  Future<List<RouteDetails>> fetchRouteDetails(String selectedRouteName) async {
    // TODO: implement fetchRouteDetails
    // throw UnimplementedError();
    http.Response response = await http.post(routeDetailsURL, body: {
      'routeName': selectedRouteName,
    });
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
