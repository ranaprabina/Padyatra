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
    image: "Annapurna01.jpg",
    length: "112",
    duration: "12",
    difficulty: "Hard",
  ),
  new BookmarkedRoute(
    routeId: "Mardi",
    routeName: "Mardi Himal Trek",
    image: "Mardi03.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new BookmarkedRoute(
    routeId: "Manaslu",
    routeName: "Manaslu Circuit",
    image: "Manaslu.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
  new BookmarkedRoute(
    routeId: "PoonHill",
    routeName: "Poon Hill Trek",
    image: "PoonHill.jpg",
    length: "112",
    difficulty: "Hard",
    duration: "12",
  ),
];
