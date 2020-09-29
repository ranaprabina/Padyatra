import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';

abstract class RouteCategoryListViewContract {
  void onLoadSearchRouteComplete(List<RouteCategory> items);
  void onLoadRouteCategoryError();
}

class RouteCategoryListPresenter {
  RouteCategoryListViewContract _routeCategoryListViewContract;
  RouteCategoryRepository _routeCategoryRepository;

  RouteCategoryListPresenter(this._routeCategoryListViewContract) {
    _routeCategoryRepository = new Injector().routeCategoryRepository;
  }

  void loadRouteCategoryName() {
    _routeCategoryRepository
        .fetchRouteCategories()
        .then((rc) =>
            _routeCategoryListViewContract.onLoadSearchRouteComplete(rc))
        .catchError((onError) =>
            _routeCategoryListViewContract.onLoadRouteCategoryError());
  }
}
