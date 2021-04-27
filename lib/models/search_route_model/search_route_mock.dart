import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'dart:async';

class MockSearchRoute implements SearchRouteRepository {
  @override
  Future<List<SearchRoute>> fetchRoutes() {
    return new Future.value(routes);
  }
}

var routes = <SearchRoute>[
  new SearchRoute(
    routeName: "Annapurna Base Camp Trek",
  ),
  new SearchRoute(
    routeName: "Mardi Himal Trek",
  ),
  new SearchRoute(
    routeName: "Poon Hill Trek",
  ),
  new SearchRoute(
    routeName: "Manaslu Circuit",
  ),
  new SearchRoute(
    routeName: "Upper Mustang Trek",
  ),
  new SearchRoute(
    routeName: "Australian Base Canp",
  )
];
