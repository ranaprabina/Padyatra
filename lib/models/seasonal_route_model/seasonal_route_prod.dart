import 'dart:convert';

import 'package:padyatra/models/seasonal_route_model/seasonal_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdSeasonalRouteRepository implements SeasonalRouteRepository {
  @override
  Future<List<SeasonalRoute>> fetchSeasonalRoutes(String season) async {
    var response = await ApiCall().getData("trekkingRoutes/season/$season");
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error occured during fetching seasonalRoutes :[Status Code : $statusCode]");
    }
    return responseBody1.map((sR) => new SeasonalRoute.toMap(sR)).toList();
  }
}
