import 'dart:async';

class UserInterestRoute {
  String serverResponse;
  String routeId;
  String routeName;
  String image;
  String length;
  String duration;
  String difficulty;

  UserInterestRoute({
    this.serverResponse,
    this.routeId,
    this.routeName,
    this.image,
    this.length,
    this.duration,
    this.difficulty,
  });
  UserInterestRoute.fromMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        length = map['route_length'],
        duration = map['duration'],
        difficulty = map['difficulty'];
}

abstract class UserInterestRouteRepository {
  Future<List<UserInterestRoute>> fetchRoutes(String userId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
