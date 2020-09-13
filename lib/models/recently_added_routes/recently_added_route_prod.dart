import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:http/http.dart' as http;

class ProdRecentlyAddedRouteRepository implements RecentlyAddedRouteRepository {
  String recentlyAddedRouteURL =
      // "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/recentlyAddedRoutes.php";
      "http://192.168.1.65/PHP%20codes/Padyatra/API's/recentlyAddedRoutes.php";

  @override
  Future<List<RecentlyAddedRoute>> fetchRecentRoutes() async {
    http.Response response = await http.get(recentlyAddedRouteURL);
    final responseBody = jsonDecode(response.body);
    print(response);
    final List responseBody1 = responseBody['recently_added_routes'];
    print(responseBody1.length);
    print(responseBody1);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error Occured : [Status Code : $statusCode]");
    }
    return responseBody1.map((rr) => new RecentlyAddedRoute.toMap(rr)).toList();
  }
}
