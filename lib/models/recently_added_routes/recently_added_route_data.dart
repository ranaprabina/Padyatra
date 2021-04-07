import 'dart:async';

class RecentlyAddedRoute {
  String serverResponse;
  String routeId;
  String routeName;
  String image;
  String length;
  String duration;
  String category;
  String dateTime;
  RecentlyAddedRoute(
      {this.routeId,
      this.routeName,
      this.image,
      this.length,
      this.duration,
      this.category,
      this.dateTime});
  RecentlyAddedRoute.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        length = map['route_length'].toString(),
        duration = map['duration'],
        category = map['category'],
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
