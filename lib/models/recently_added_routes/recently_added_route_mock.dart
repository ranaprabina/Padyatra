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
    image: "AC1.png",
    length: "112km",
    duration: "12 days",
  ),
  new RecentlyAddedRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "AC2.png",
    length: "112km",
    duration: "12 days",
  ),
  new RecentlyAddedRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "AC3.png",
    length: "112km",
    duration: "12 days",
  ),
  new RecentlyAddedRoute(
    routeId: "PoonHill",
    routeName: "Annapurna Base Camp",
    image: "AC4.png",
    length: "112km",
    duration: "12 days",
  ),
];
