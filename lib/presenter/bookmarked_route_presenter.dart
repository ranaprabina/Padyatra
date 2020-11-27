import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_data.dart';

abstract class BookmarkedRouteListViewContract {
  void onLoadBookmarekdRouteComplete(List<BookmarkedRoute> items);
  void onLoadBookmarkedRouteError();
}

class BookmarkedRouteListPresenter {
  BookmarkedRouteListViewContract _viewContract;
  BookmarkedRouteRepository _bookmarkedRouteRepository;

  BookmarkedRouteListPresenter(this._viewContract) {
    _bookmarkedRouteRepository = new Injector().bookmarkedRouteRepository;
  }

  void loadBookmarkedRoutes(String userId) {
    _bookmarkedRouteRepository
        .fetchBookmarkedRoutes(userId)
        .then((br) => _viewContract.onLoadBookmarekdRouteComplete(br))
        .catchError((onError) => _viewContract.onLoadBookmarkedRouteError());
  }
}
