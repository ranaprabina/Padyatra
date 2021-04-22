class DayPerformance {
  String serverResponse;
  String message;
  DayPerformance({this.serverResponse, this.message});

  DayPerformance.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        message = map['message'];
}

abstract class DayPerformanceRepository {
  Future<List<DayPerformance>> storeDayPerformance(
    String userId,
    String routeId,
    String latitudeReached,
    String longitudeReached,
    String trekkingComplete,
  );
}

class FetchDataException1 implements Exception {
  final _message;
  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
