import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';

abstract class SearchRouteListViewContract {
  void onLoadSearchRouteComplete(List<SearchRoute> items);
  void onLoadSeachRouteError();
}

class SearchRouteListPresenter {
  SearchRouteListViewContract _viewContract;
  SearchRouteRepository _repository;

  SearchRouteListPresenter(this._viewContract) {
    _repository = new Injector().searchRouteRepository;
  }

  void loadRoutesName() {
    _repository
        .fetchRoutes()
        .then((sr) => _viewContract.onLoadSearchRouteComplete(sr))
        .catchError((onError) => _viewContract.onLoadSeachRouteError());
  }
}
