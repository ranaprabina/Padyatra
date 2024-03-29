import 'dart:convert';

import 'package:padyatra/models/day_performance_model/day_performance_data.dart';
import 'package:padyatra/services/api.dart';

class ProdDayPerformanceRepository implements DayPerformanceRepository {
  @override
  Future<List<DayPerformance>> storeDayPerformance(
      String userId,
      String routeId,
      String latitudeReached,
      String longitudeReached,
      String trekkingCompleted) async {
    var data = {
      'u_id': userId,
      'route_id': routeId,
      'lat_reached': latitudeReached,
      'lng_reached': longitudeReached,
      'trekking_completed': trekkingCompleted
    };
    try {
      var response = await ApiCall().postData(data, 'dailyPerformance');
      final responseBody = jsonDecode(response.body);
      final List responseBody1 = responseBody['serverResponse'];
      print(responseBody1);
      final statusCode = response.statusCode;

      if (statusCode != 200 && responseBody == null) {
        throw new FetchDataException2(
            "An error occured : [Status Code :  $statusCode, $responseBody]");
      }
      return responseBody1.map((sr) => new DayPerformance.toMap(sr)).toList();
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Future<List<DayPerformance>> getDayPerformance(
      String routeId, String userId) async {
    var data = {
      'u_id': userId,
      'route_id': routeId,
    };
    try {
      var response = await ApiCall().postData(data, 'dayPerformance');
      final responseBody = jsonDecode(response.body);
      final List responseBody1 = responseBody['serverResponse'];
      final statusCode = response.statusCode;

      if (statusCode != 200 && responseBody == null) {
        throw new FetchDataException2(
            "An error occured : [Status Code :  $statusCode, $responseBody]");
      }
      return responseBody1.map((sR) => new DayPerformance.fromMap(sR)).toList();
    } catch (e) {
      print(e);
      return e;
    }
  }
}
