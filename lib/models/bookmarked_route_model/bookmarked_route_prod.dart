import 'dart:convert';

import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_data.dart';
import 'package:padyatra/services/api.dart';

class ProdBookmarkedRouteRepository implements BookmarkedRouteRepository {
  @override
  Future<List<BookmarkedRoute>> fetchBookmarkedRoutes(String userId) async {
    var data = {
      'id': userId,
    };
    var response = await ApiCall().postData(data, 'bookmarkedRoute');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final statusCode = response.statusCode;

    if (statusCode != 200 && responseBody == null) {
      throw new FetchDataException(
          "An error occured: [Status Code : $statusCode]");
    }
    return responseBody1.map((br) => new BookmarkedRoute.toMap(br)).toList();
  }
}
