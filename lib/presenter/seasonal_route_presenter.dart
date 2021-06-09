import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/seasonal_route_model/seasonal_route_data.dart';

abstract class SeasonalRouteListViewContract {
  void onLoadSeasonalRouteComplete(List<SeasonalRoute> items);
  void onLoadSeasonalRouteError();
}

class SeasonalRouteListPresenter {
  SeasonalRouteListViewContract _viewContract;
  SeasonalRouteRepository _seasonalRouteRepository;

  SeasonalRouteListPresenter(this._viewContract) {
    _seasonalRouteRepository = new Injector().seasonalRouteRepository;
  }

  void loadSeasonalRoutes(String season) {
    _seasonalRouteRepository
        .fetchSeasonalRoutes(season)
        .then((sr) => _viewContract.onLoadSeasonalRouteComplete(sr))
        .catchError((onError) => _viewContract.onLoadSeasonalRouteError());
  }
}
