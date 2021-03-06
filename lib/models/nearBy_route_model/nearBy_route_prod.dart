import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdNearByRouteRepository implements NearByRouteRepository {
  @override
  Future<List<NearByRoute>> fetchNearByRoutes() async {
    var data = {
      'latitude': '28.4565',
      'longitude': '83.32343',
    };
    var response =
        await ApiCall().postData(data, 'trekkingRoutes/getNearByRoutes');
    print(response);
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    print(responseBody1.length);
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error Occured : [Status Code : $statusCode]");
    }
    return responseBody1.map((nr) => new NearByRoute.toMap(nr)).toList();
  }
}
