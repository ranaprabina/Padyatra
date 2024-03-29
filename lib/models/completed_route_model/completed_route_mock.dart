import 'package:padyatra/models/completed_route_model/completed_route_data.dart';

class MockCompletesRoute implements CompletedRouteRepository {
  @override
  Future<List<CompletedRoute>> fetchCompletedRoutes(String userId) async {
    return new Future.value(completedRoute);
  }
}

var completedRoute = <CompletedRoute>[
  new CompletedRoute(
    routeId: "PoonHill",
    routeName: "Poon Hill Trek",
    image: "PoonHill.jpg",
    duration: '4',
    routeLength: "40",
    completedId: '2',
    totalTrekkedDays: '4',
    trekStartedAt: "2020-11-28 21:01:22",
    trekEndedAt: "2020-12-01 21:01:22",
  ),
  new CompletedRoute(
    routeId: "Langtang Trek",
    routeName: "Langtang Valley Trek",
    image: "Langtang.jpg",
    duration: '11',
    routeLength: "'100",
    completedId: '4',
    totalTrekkedDays: '11',
    trekStartedAt: "2020-11-20 17:40:13",
    trekEndedAt: "2020-12-04 17:40:13",
  ),
  new CompletedRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    duration: '4',
    routeLength: "40",
    completedId: '2',
    totalTrekkedDays: '4',
    trekStartedAt: "2020-11-28 21:01:22",
    trekEndedAt: "2020-12-01 21:01:22",
  )
];
