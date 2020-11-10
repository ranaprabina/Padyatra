import 'dart:convert';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'dart:async';
import 'package:padyatra/services/api.dart';

class ProdUserInterestRouteRepository implements UserInterestRouteRepository {
  @override
  Future<List<UserInterestRoute>> fetchRoutes(String userId) async {
    var data = {
      'userId': userId,
    };
    var response = await ApiCall()
        .postData(data, 'trekkingRoutes/userInterestedTrekkingRoute');
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['User_Interested_Trekking_Routes'];
    // final List responseBody2 = responseBody['Category_Name'];
    print(responseBody1.length);
    print(responseBody1);
    // print(responseBody2);
    final statusCode = response.statusCode;
    print(statusCode);

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error occured : [Status Code : $statusCode]");
    }
    return responseBody1
        .map((ur) => new UserInterestRoute.fromMap(ur))
        .toList();
  }
}
