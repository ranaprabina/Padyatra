class NearByRoute {
  String routeId;
  String routeName;
  String image;
  String routeLength;
  String duration;
  String difficulty;
  NearByRoute({
    this.routeId,
    this.routeName,
    this.image,
    this.routeLength,
    this.duration,
    this.difficulty,
  });

  NearByRoute.toMap(Map<String, dynamic> map)
      : routeId = map['route_id'],
        routeName = map['route_name'],
        routeLength = map['route_length'].toString(),
        duration = map['duration'],
        difficulty = map['difficulty'];
}

abstract class NearByRouteRepository {
  Future<List<NearByRoute>> fetchNearByRoutes();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
