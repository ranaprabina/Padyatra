import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_data.dart';

class MockBookmarkedRoute implements BookmarkedRouteRepository {
  @override
  Future<List<BookmarkedRoute>> fetchBookmarkedRoutes(String usreId) {
    return new Future.value(bookmarkedRoutes);
  }
}

var bookmarkedRoutes = <BookmarkedRoute>[
  new BookmarkedRoute(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp",
    image: "AC1.png",
    length: "112km",
    duration: "12 days",
    difficulty: "Hard",
  ),
  new BookmarkedRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "AC2.png",
    length: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
  new BookmarkedRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "AC3.png",
    length: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
  new BookmarkedRoute(
    routeId: "PoonHill",
    routeName: "Annapurna Base Camp",
    image: "AC4.png",
    length: "112km",
    difficulty: "Hard",
    duration: "12 days",
  ),
];
