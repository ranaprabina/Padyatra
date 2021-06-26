import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/day_performance_model/day_performance_data.dart';

abstract class DayPerformanceListViewContract {
  void onStoreComplete(List<DayPerformance> itens);
  void onStoreError();
  void onLoadComplete(List<DayPerformance> items);
  void onLoadError();
}

class DayPerformanceListPresenter {
  DayPerformanceListViewContract _viewContract;
  DayPerformanceRepository _dayPerformanceRepository;
  DayPerformanceListPresenter(this._viewContract) {
    _dayPerformanceRepository = new Injector().dayPerformanceRepository;
  }

  void sendDayPerformance(String userId, String routeId, String latitudeReached,
      String longitudeReached, String trekkingCompleted) {
    _dayPerformanceRepository
        .storeDayPerformance(userId, routeId, latitudeReached, longitudeReached,
            trekkingCompleted)
        .then((sr) => _viewContract.onStoreComplete(sr))
        .catchError((onError) => _viewContract.onStoreError());
  }

  void getDayPerformance(String routeId, String userId) {
    _dayPerformanceRepository
        .getDayPerformance(routeId, userId)
        .then((sR) => _viewContract.onLoadComplete(sR))
        .catchError((onError) => _viewContract.onLoadError());
  }
}
