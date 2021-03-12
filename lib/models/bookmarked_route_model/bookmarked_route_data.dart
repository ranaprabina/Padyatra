class BookmarkedRoute {
  String serverResponse;
  String message;
  String routeId;
  String routeName;
  String image;
  String length;
  String duration;
  String difficulty;

  BookmarkedRoute({
    this.serverResponse,
    this.message,
    this.routeId,
    this.routeName,
    this.image,
    this.length,
    this.duration,
    this.difficulty,
  });
  BookmarkedRoute.toMap(Map<String, dynamic> map)
      : serverResponse = map['Response'],
        message = map['message'],
        routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        length = map['route_length'].toString(),
        duration = map['duration'],
        difficulty = map['difficulty'];
}

abstract class BookmarkedRouteRepository {
  Future<List<BookmarkedRoute>> fetchBookmarkedRoutes(String userId);
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
