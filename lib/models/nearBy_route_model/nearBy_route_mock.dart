import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'dart:async';

class MockNearByRoute implements NearByRouteRepository {
  @override
  Future<List<NearByRoute>> fetchNearByRoutes(
      double latitude, double longitude) {
    return new Future.value(routes);
  }
}

var routes = <NearByRoute>[
  new NearByRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "Annapurna01.jpg",
    routeLength: "112",
    duration: "12",
    difficulty: "Hard",
  ),
  new NearByRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    routeLength: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new NearByRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "Manaslu.jpg",
    routeLength: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new NearByRoute(
    routeId: "PoonHill",
    routeName: "Poon Hill Trek",
    image: "PoonHill.jpg",
    routeLength: "112",
    difficulty: "Hard",
    duration: "12",
  ),
];
