import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_data.dart';
import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_mock.dart';
import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_prod.dart';
import 'package:padyatra/models/completed_route_model/completed_route_data.dart';
import 'package:padyatra/models/completed_route_model/completed_route_mock.dart';
import 'package:padyatra/models/completed_route_model/completed_route_prod.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinate_prod.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_mock.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_mock.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_prod.dart';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_mock.dart';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_prod.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_mock.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_prod.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/models/route_details_model/route_details_mock.dart';
import 'package:padyatra/models/route_details_model/route_details_prod.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_mock.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_prod.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:padyatra/models/search_route_model/search_route_mock.dart';
import 'package:padyatra/models/search_route_model/search_route_prod.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_mock.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_prod.dart';
import 'package:padyatra/models/user_login_model/user_login_data.dart';
import 'package:padyatra/models/user_login_model/user_login_mock.dart';
import 'package:padyatra/models/user_login_model/user_login_prod.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_mock.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_prod.dart';
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

  RouteCategoryRepository get routeCategoryRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockRouteCategory();
      default:
        return new ProdRouteCategoryRepository();
    }
  }

  InsertUserInterestRouteCategoryRepository
      get insertUserInterestRouteCategoryRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockInsertUserInterestRouteCategory();
      default:
        return new ProdInsertUserInterestRouteCategoryRepository();
    }
  }

  GetRouteCoordinatesRepository get getRouteCoordinatesRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockGetRouteCoordinates();

      default:
        return new ProdGetRouteCoordinatesRepository();
    }
  }

  UserLoginRepository get userLoginRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockUserLogin();

      default:
        return new ProdUserLoginRepository();
    }
  }

  UserSignUpRepository get userSignUpRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockUserSignUp();

      default:
        return new ProdUserSignUpRepository();
    }
  }

  BookmarkedRouteRepository get bookmarkedRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockBookmarkedRoute();

      default:
        return new ProdBookmarkedRouteRepository();
    }
  }

  CompletedRouteRepository get completedRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockCompletesRoute();

      default:
        return new ProdCompletedRouteRepository();
    }
  }

  NearByRouteRepository get nearByRouteRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockNearByRoute();

      default:
        return new ProdNearByRouteRepository();
    }
  }
}
