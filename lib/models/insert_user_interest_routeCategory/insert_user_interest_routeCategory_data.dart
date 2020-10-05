class InsertUserInterestRouteCategory {
  String serverResponseMessage;
  String userId;
  // String routeCategoryName;

  InsertUserInterestRouteCategory({
    this.serverResponseMessage,
    this.userId,
  });

  InsertUserInterestRouteCategory.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'];
}

abstract class InsertUserInterestRouteCategoryRepository {
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}