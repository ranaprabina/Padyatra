import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'dart:async';

class MockNearByRoute implements NearByRouteRepository {
  @override
  Future<List<NearByRoute>> fetchNearByRoutes() {
    return new Future.value(routes);
  }
}

var routes = <NearByRoute>[
  new NearByRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "AC1.png",
    routeLength: "112km",
    duration: "12 days",
    difficulty: "Hard",
  ),
  new NearByRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "AC2.png",
    routeLength: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
  new NearByRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "AC3.png",
    routeLength: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
  new NearByRoute(
    routeId: "PoonHill",
    routeName: "Annapurna Base Camp",
    image: "AC4.png",
    routeLength: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
];
