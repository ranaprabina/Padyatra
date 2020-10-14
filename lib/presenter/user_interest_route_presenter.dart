import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';

abstract class UserInterestRouteListViewContract {
  void onLoadUserInterestRouteComplete(List<UserInterestRoute> items);
  void onLoadUserInterstRouteError();
}

class UserInterestRouteListPresenter {
  UserInterestRouteListViewContract _viewContract;
  UserInterestRouteRepository _repository;

  UserInterestRouteListPresenter(this._viewContract) {
    _repository = new Injector().userInterestRouteRepository;
  }

  void loadUserRoutes(String userId) {
    _repository
        .fetchRoutes(userId)
        .then((ur) => _viewContract.onLoadUserInterestRouteComplete(ur))
        .catchError((onError) => _viewContract.onLoadUserInterstRouteError());
  }
}
