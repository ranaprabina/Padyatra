class InsertUserInterestRouteCategory {
  String serverResponseMessage;
  String userId;
  String messsage;
  // String routeCategoryName;

  InsertUserInterestRouteCategory(
      {this.serverResponseMessage, this.userId, this.messsage});

  InsertUserInterestRouteCategory.fromMap(Map<String, dynamic> map)
      : serverResponseMessage = map['Response'],
        messsage = map['message'],
        userId = map['userId'];
}

abstract class InsertUserInterestRouteCategoryRepository {
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName, String userId);
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
