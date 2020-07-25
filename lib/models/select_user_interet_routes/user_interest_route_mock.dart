import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'dart:async';

class MockUserInterestRoute implements UserInterestRouteRepository {
  @override
  Future<List<UserInterestRoute>> fetchRoutes() {
    // throw UnimplementedError();
    return new Future.value(routes);
  }
}

var routes = <UserInterestRoute>[
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "AC1.png",
    length: "112km",
    duration: "12 days",
  ),
  new UserInterestRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "AC2.png",
    length: "112km",
    duration: "12 days",
  ),
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "AC3.png",
    length: "112km",
    duration: "12 days",
  ),
  new UserInterestRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "AC4.png",
    length: "112km",
    duration: "12 days",
  ),
];
