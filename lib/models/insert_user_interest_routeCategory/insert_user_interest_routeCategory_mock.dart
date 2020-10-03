import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';

class MockInsertUserInterestRouteCategory
    implements InsertUserInterestRouteCategoryRepository {
  @override
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName) {
    // TODO: implement sendRouteCategory
    // throw UnimplementedError();
    return new Future.value(serverResponse);
  }
}

var serverResponse = <InsertUserInterestRouteCategory>[
  new InsertUserInterestRouteCategory(
    serverResponseMessage: "New_Insertion_success",
    userId: '16',
  )
];
