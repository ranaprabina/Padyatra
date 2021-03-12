class NearByRoute {
  String response;
  String routeId;
  String routeName;
  String image;
  String routeLength;
  String duration;
  String difficulty;
  NearByRoute({
    this.response,
    this.routeId,
    this.routeName,
    this.image,
    this.routeLength,
    this.duration,
    this.difficulty,
  });

  NearByRoute.toMap(Map<String, dynamic> map)
      : response = map['Response'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        routeLength = map['route_length'].toString(),
        duration = map['duration'],
        difficulty = map['difficulty'];
}

abstract class NearByRouteRepository {
  Future<List<NearByRoute>> fetchNearByRoutes(
      double latitude, double longitude);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
