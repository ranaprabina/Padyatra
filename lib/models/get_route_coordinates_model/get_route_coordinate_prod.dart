import 'dart:convert';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/services/api.dart';

class ProdGetRouteCoordinatesRepository
    implements GetRouteCoordinatesRepository {
  @override
  Future<List<GetRouteCoordinates>> getRouteCoordinates(String routeID) async {
    var data = {
      'route_id': routeID,
    };

    var response = await ApiCall().postData(data, 'trekkingRoutes/coordinates');
    final responseBody = jsonDecode(response.body);

    final List responseBody1 = responseBody['serverResponse'];

    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null || responseBody1 == null) {
      try {
        throw new FetchDataException1(
            "An error occured during retrieving route coordinates : [Status Code : $statusCode], [ServerResponse : $responseBody1]");
      } catch (e) {
        print(e);
      }
    } else {
      return responseBody1
          .map((rC) => new GetRouteCoordinates.fromMap(rC))
          .toList();
    }
  }
}
