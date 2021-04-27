import 'package:padyatra/models/day_performance_model/day_performance_data.dart';

class MockDayPerformance implements DayPerformanceRepository {
  @override
  Future<List<DayPerformance>> storeDayPerformance(
      String userId,
      String routeId,
      String latitudeReached,
      String longitudeReached,
      String trekkingComplete) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <DayPerformance>[
  new DayPerformance(
    serverResponse: "Insertion_Success",
    message: "today performance was inserted successfully",
  )
];
