import 'dart:convert';
import 'dart:async';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:http/http.dart' as http;

class ProdSearchRouteRepsitory implements SearchRouteRepository {
  String fetchRouteUrl =
      // "http://192.168.1.68:8888/Padyatra/PHP%20codes/Padyatra-ServerSide/API's/selectAllRoutes.php";
      "http://192.168.1.65/PHP%20codes/Padyatra/API's/selectAllRoutes.php";
  @override
  Future<List<SearchRoute>> fetchRoutes() async {
    // TODO: implement fetchRoutes
    // throw UnimplementedError();
    http.Response response = await http.get(fetchRouteUrl);
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    final List responseBody1 = responseBody['Routes'];
    print(responseBody1);

    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException(
          "An error occured : [Status Code : $statusCode");
    }
    return responseBody1.map((sr) => new SearchRoute.fromMap(sr)).toList();
  }
}
