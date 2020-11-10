import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdRecentlyAddedRouteRepository implements RecentlyAddedRouteRepository {
  @override
  Future<List<RecentlyAddedRoute>> fetchRecentRoutes() async {
    var response =
        await ApiCall().getData('trekkingRoutes/recentlyAddedRoutes');
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
