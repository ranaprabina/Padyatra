import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/completed_route_model/completed_route_data.dart';

abstract class CompletedRouteListViewContract {
  void onLoadCompletedRouteComplete(List<CompletedRoute> items);
  void onLoadCompletedRouteError();
}

class CompletedRouteListPresenter {
  CompletedRouteListViewContract _viewContract;
  CompletedRouteRepository _completedRouteRepository;

  CompletedRouteListPresenter(this._viewContract) {
    _completedRouteRepository = new Injector().completedRouteRepository;
  }

  void loadCompletedRoutes(String userId) {
    _completedRouteRepository
        .fetchCompletedRoutes(userId)
        .then((cr) => _viewContract.onLoadCompletedRouteComplete(cr))
        .catchError((onError) => _viewContract.onLoadCompletedRouteError());
  }
}
