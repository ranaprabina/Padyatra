class RouteCategory {
  String categoryName;
  RouteCategory({
    this.categoryName,
  });

  RouteCategory.fromMap(Map<String, dynamic> map)
      : categoryName = map['category_name'];
}

abstract class RouteCategoryRepository {
  Future<List<RouteCategory>> fetchRouteCategories();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "EXception: $_message";
  }
}
