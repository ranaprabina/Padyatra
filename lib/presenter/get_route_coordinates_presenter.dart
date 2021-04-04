import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';

abstract class GetRouteCoordinatesListViewContract {
  void onGetRouteCoordinatesComplete(List<GetRouteCoordinates> items);
  void onGetRouteCoordinatesError();
}

class GetRouteCoordinatesListPresenter {
  GetRouteCoordinatesListViewContract _viewContract;
  GetRouteCoordinatesRepository _repository;

  GetRouteCoordinatesListPresenter(this._viewContract) {
    _repository = new Injector().getRouteCoordinatesRepository;
  }

  void loadServerResponseCoordinates(String routeID) {
    _repository
        .getRouteCoordinates(routeID)
        .then((sR) => _viewContract.onGetRouteCoordinatesComplete(sR))
        .catchError((onError) => _viewContract.onGetRouteCoordinatesError());
  }
}
