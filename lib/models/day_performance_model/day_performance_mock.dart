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

  @override
  Future<List<DayPerformance>> getDayPerformance(
      String routeId, String userId) {
    return new Future.value(serverResponse1);
  }
}

var serverResponse = <DayPerformance>[
  new DayPerformance(
    serverResponse: "Insertion_Success",
    message: "today performance was inserted successfully",
  )
];
var serverResponse1 = <DayPerformance>[
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 0,
  ),
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 0,
  ),
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 0,
  ),
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 0,
  ),
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 0,
  ),
  new DayPerformance(
    dayId: 1,
    userId: 5,
    lattitudeReached: 28.34234,
    longitudeReached: 83.32423,
    trekkingCompleted: 1,
  ),
];
