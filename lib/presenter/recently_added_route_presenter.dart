import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';

abstract class RecentlyAddedRouteListViewContract {
  void onLoadRecentlyAddedRouteComplete(List<RecentlyAddedRoute> items);
  void onLoadRecentlyAddedRouteError();
}

class RecentlyAddedRouteListPresenter {
  RecentlyAddedRouteListViewContract _viewContract;
  RecentlyAddedRouteRepository _repository;

  RecentlyAddedRouteListPresenter(this._viewContract) {
    _repository = new Injector().recentlyAddedRouteRepository;
  }
  void loadRecentRoutes() {
    _repository
        .fetchRecentRoutes()
        .then((rr) => _viewContract.onLoadRecentlyAddedRouteComplete(rr))
        .catchError((onError) => _viewContract.onLoadRecentlyAddedRouteError());
  }
}
