import 'package:padyatra/models/seasonal_route_model/seasonal_route_data.dart';

class MockSeasonalRoute implements SeasonalRouteRepository {
  @override
  Future<List<SeasonalRoute>> fetchSeasonalRoutes(String season) {
    return new Future.value(seasonalRoutes);
  }
}

var seasonalRoutes = <SeasonalRoute>[
  new SeasonalRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "Annapurna01.jpg",
    length: "112",
    duration: "12",
    category: "Hard",
  ),
  new SeasonalRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    length: "112",
    category: "Hard",
    duration: "12",
  ),
  new SeasonalRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "Manaslu.jpg",
    length: "112",
    category: "Hard",
    duration: "12",
  ),
  new SeasonalRoute(
    routeId: "PoonHill",
    routeName: "Poon Hill Trek",
    image: "PoonHill.jpg",
    length: "112",
    category: "Hard",
    duration: "12",
  ),
];
