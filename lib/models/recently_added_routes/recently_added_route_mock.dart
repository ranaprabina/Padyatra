import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'dart:async';

class MockRecentlyAddedRoute implements RecentlyAddedRouteRepository {
  @override
  Future<List<RecentlyAddedRoute>> fetchRecentRoutes() {
    return new Future.value(routes);
  }
}

var routes = <RecentlyAddedRoute>[
  new RecentlyAddedRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "Annapurna01.jpg",
    length: "112",
    duration: "12",
    difficulty: "Hard",
  ),
  new RecentlyAddedRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new RecentlyAddedRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "Manaslu.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new RecentlyAddedRoute(
    routeId: "PoonHill",
    routeName: "Poon Hill Trek",
    image: "PoonHill.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
];
