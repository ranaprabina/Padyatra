class SeasonalRoute {
  String serverResponse;
  String message;
  String routeId;
  String routeName;
  String image;
  String length;
  String duration;
  String category;

  SeasonalRoute({
    this.serverResponse,
    this.message,
    this.routeId,
    this.routeName,
    this.image,
    this.length,
    this.duration,
    this.category,
  });

  SeasonalRoute.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        message = map['message'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        length = map['route_length'].toString(),
        duration = map['duration'],
        category = map['category'];
}

abstract class SeasonalRouteRepository {
  Future<List<SeasonalRoute>> fetchSeasonalRoutes(String season);
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
