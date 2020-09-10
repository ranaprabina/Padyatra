import 'dart:convert';

import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ProdUserInterestRouteRepository implements UserInterestRouteRepository {
  String userInterestRouteUrl =
      "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/selectUserInterestTrekkingRoute.php";
  @override
  Future<List<UserInterestRoute>> fetchRoutes() async {
    http.Response response = await http.get(userInterestRouteUrl);
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['User_Interested_Selected_Routes'];
    // final List responseBody2 = responseBody['Category_Name'];
    print(responseBody1.length);
    print(responseBody1);
    // print(responseBody2);
    final statusCode = response.statusCode;
    print(statusCode);

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error occured : [Status Code : $statusCode]");
    }
    return responseBody1
        .map((ur) => new UserInterestRoute.fromMap(ur))
        .toList();
  }
}
