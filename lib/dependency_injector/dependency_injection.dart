import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_mock.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_prod.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/models/route_details_model/route_details_mock.dart';
import 'package:padyatra/models/route_details_model/route_details_prod.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:padyatra/models/search_route_model/search_route_mock.dart';
import 'package:padyatra/models/search_route_model/search_route_prod.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_mock.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_prod.dart';
import '../models/select_user_interet_routes/user_interest_route_data.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singelton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singelton;
  }
  Injector._internal();

  UserInterestRouteRepository get userInterestRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockUserInterestRoute();
      default:
        return new ProdUserInterestRouteRepository();
    }
  }

  RecentlyAddedRouteRepository get recentlyAddedRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockRecentlyAddedRoute();
      default:
        return new ProdRecentlyAddedRouteRepository();
    }
  }

  SearchRouteRepository get searchRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockSearchRoute();
      default:
        return new ProdSearchRouteRepsitory();
    }
  }

  RouteDetailsRepository get routeDetailsRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockRouteDetails();
      default:
        return new ProdRouteDetailsRepository();
    }
  }
}
