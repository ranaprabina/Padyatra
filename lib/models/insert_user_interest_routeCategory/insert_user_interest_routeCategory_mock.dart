import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';

class MockInsertUserInterestRouteCategory
    implements InsertUserInterestRouteCategoryRepository {
  @override
  Future<List<InsertUserInterestRouteCategory>> sendRouteCategory(
      String categoryName, String userId) {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <InsertUserInterestRouteCategory>[
  new InsertUserInterestRouteCategory(
    serverResponseMessage: "New_Insertion_success",
    messsage: "selected category was inserted successfully",
    userId: '16',
  )
];
