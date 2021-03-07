import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdNearByRouteRepository implements NearByRouteRepository {
  @override
  Future<List<NearByRoute>> fetchNearByRoutes(
      double latitude, double longitude) async {
    var data = {
      'latitude': latitude,
      'longitude': longitude,
    };
    var response =
        await ApiCall().postData(data, 'trekkingRoutes/getNearByRoutes');
    print(response);
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error Occured : [Status Code : $statusCode]");
    }
    return responseBody1.map((nr) => new NearByRoute.toMap(nr)).toList();
  }
}
