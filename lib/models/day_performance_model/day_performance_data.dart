class DayPerformance {
  String serverResponse;
  String message;
  int dayId;
  int userId;
  String routeId;
  double lattitudeReached;
  double longitudeReached;
  int trekkingCompleted;
  DayPerformance({
    this.serverResponse,
    this.message,
    this.dayId,
    this.userId,
    this.routeId,
    this.lattitudeReached,
    this.longitudeReached,
    this.trekkingCompleted,
  });

  DayPerformance.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        message = map['message'],
        dayId = map['day_id'],
        userId = map['u_id'],
        lattitudeReached = map['lat_reached'],
        longitudeReached = map['lng_reached'];

  DayPerformance.fromMap(Map<String, dynamic> map)
      : dayId = map['day_id'],
        userId = map['u_id'],
        lattitudeReached = map['lat_reached'],
        longitudeReached = map['lng_reached'],
        trekkingCompleted = map['trekking_completed'];
}

abstract class DayPerformanceRepository {
  Future<List<DayPerformance>> storeDayPerformance(
    String userId,
    String routeId,
    String latitudeReached,
    String longitudeReached,
    String trekkingComplete,
  );

  Future<List<DayPerformance>> getDayPerformance(String routeId, String userId);
}

class FetchDataException2 implements Exception {
  final _message;
  FetchDataException2([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
