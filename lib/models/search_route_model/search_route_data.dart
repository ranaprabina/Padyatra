import 'dart:async';

class SearchRoute {
  String routeName;
  SearchRoute({
    this.routeName,
  });

  SearchRoute.fromMap(Map<String, dynamic> map) : routeName = map['route_name'];
}

abstract class SearchRouteRepository {
  Future<List<SearchRoute>> fetchRoutes();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
