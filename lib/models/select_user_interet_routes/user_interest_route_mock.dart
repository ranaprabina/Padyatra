import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'dart:async';

class MockUserInterestRoute implements UserInterestRouteRepository {
  @override
  Future<List<UserInterestRoute>> fetchRoutes(String userId) {
    // throw UnimplementedError();
    return new Future.value(routes);
  }
}

var routes = <UserInterestRoute>[
  // new UserInterestRoute(
  //   serverResponse: "categories_not_selected",
  // ),
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp Trek",
    image: "Annapurna01.jpg",
    length: 112,
    duration: "12",
    difficulty: "Hard",
  ),
  new UserInterestRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    length: 112,
    duration: "12",
    difficulty: "Moderate",
  ),
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp Trek",
    image: "Annapurna01.jpg",
    length: 112,
    duration: "12",
    difficulty: "Hard",
  ),
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp Trek",
    image: "Annapurna01.jpg",
    length: 112,
    duration: "12",
    difficulty: "Hard",
  ),
];
