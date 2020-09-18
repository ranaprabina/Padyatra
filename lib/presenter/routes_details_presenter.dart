import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';

abstract class RouteDetailsListViewContract {
  void onLoadRouteDetailsComplete(List<RouteDetails> items);
  void onLoadRouteDetailsError();
}

class RouteDetailsListPresenter {
  RouteDetailsListViewContract _viewContract;
  RouteDetailsRepository _repository;

  RouteDetailsListPresenter(this._viewContract) {
    _repository = new Injector().routeDetailsRepository;
  }
  void loadRouteDetails(selectedRouteName) {
    _repository
        .fetchRouteDetails(selectedRouteName)
        .then((rd) => _viewContract.onLoadRouteDetailsComplete(rd))
        .catchError((onError) => _viewContract.onLoadRouteDetailsError());
  }
}
