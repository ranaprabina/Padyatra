import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';

class MockRouteCategory implements RouteCategoryRepository {
  @override
  Future<List<RouteCategory>> fetchRouteCategories() {
    return new Future.value(categories);
  }
}

var categories = <RouteCategory>[
  new RouteCategory(
    categoryName: "Hard",
  ),
  new RouteCategory(
    categoryName: "Moderate",
  ),
  new RouteCategory(
    categoryName: "Easy",
  ),
  new RouteCategory(
    categoryName: "Long",
  ),
  new RouteCategory(
    categoryName: "Short",
  ),
  new RouteCategory(
    categoryName: "Medium",
  ),
  new RouteCategory(
    categoryName: "Waterfall",
  ),
];
