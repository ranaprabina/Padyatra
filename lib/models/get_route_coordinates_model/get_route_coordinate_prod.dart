import 'dart:convert';

import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:http/http.dart' as http;

class ProdGetRouteCoordinatesRepository
    implements GetRouteCoordinatesRepository {
  String getcoordinates = "http://192.168.1.68:8888/demo/getGeoCoordinates.php";

  @override
  Future<List<GetRouteCoordinates>> getRouteCoordinates() async {
    http.Response response = await http.get(getcoordinates);
    final responseBody = jsonDecode(response.body);

    final List responseBody1 = responseBody['serverResponse'];

    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      throw new FetchDataException1(
          "An error occured during retrieving route coordinates : [Status Code : $statusCode");
    }
    return responseBody1
        .map((rC) => new GetRouteCoordinates.fromMap(rC))
        .toList();
  }
}
