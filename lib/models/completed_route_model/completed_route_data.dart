class CompletedRoute {
  String serverResponse;
  String message;
  String routeId;
  String routeName;
  String image;
  String duration;
  String routeLength;
  String completedId;
  String totalTrekkedDays;
  String trekStartedAt;
  String trekEndedAt;
  CompletedRoute({
    this.serverResponse,
    this.message,
    this.routeId,
    this.routeName,
    this.image,
    this.duration,
    this.routeLength,
    this.completedId,
    this.totalTrekkedDays,
    this.trekStartedAt,
    this.trekEndedAt,
  });

  CompletedRoute.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        message = map['message'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        duration = map['duration'],
        routeLength = map['route_length'].toString(),
        completedId = map['completed_id'].toString(),
        totalTrekkedDays = map['trekCompletedInDays'].toString(),
        trekStartedAt = map['started_trekking_at'].toString(),
        trekEndedAt = map['ended_trekking_at'].toString();
}

abstract class CompletedRouteRepository {
  Future<List<CompletedRoute>> fetchCompletedRoutes(String userId);
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
