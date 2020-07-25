import 'dart:async';

class RecentlyAddedRoute {
  String routeId;
  String routeName;
  String image;
  String length;
  String duration;
  String difficulty;
  String dateTime;
  RecentlyAddedRoute(
      {this.routeId,
      this.routeName,
      this.image,
      this.length,
      this.duration,
      this.difficulty,
      this.dateTime});
  RecentlyAddedRoute.toMap(Map<String, dynamic> map)
      : routeId = map['route_id'],
        routeName = map['route_name'],
        length = map['route_length'],
        duration = map['duration'],
        difficulty = map['difficulty'],
        dateTime = map['route_added_at'];
}

abstract class RecentlyAddedRouteRepository {
  Future<List<RecentlyAddedRoute>> fetchRecentRoutes();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
