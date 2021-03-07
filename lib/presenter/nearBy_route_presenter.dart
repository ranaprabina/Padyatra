import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';

abstract class NearByRouteListViewContract {
  void onLoadNearByRouteComplete(List<NearByRoute> items);
  void onLoadNearByRouteError();
}

class NearByRouteListPresenter {
  NearByRouteListViewContract _viewContract;
  NearByRouteRepository _nearByRouteRepository;

  NearByRouteListPresenter(this._viewContract) {
    _nearByRouteRepository = new Injector().nearByRouteRepository;
  }

  void loadNearByRoutes(double latitude, double longitude) {
    _nearByRouteRepository
        .fetchNearByRoutes(latitude, longitude)
        .then((nr) => _viewContract.onLoadNearByRouteComplete(nr))
        .catchError((onError) => _viewContract.onLoadNearByRouteError());
  }
}
