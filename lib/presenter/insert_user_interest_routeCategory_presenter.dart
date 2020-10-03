import 'package:padyatra/dependency_injector/dependency_injection.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';

abstract class InsertUserInterestRouteCategoryListViewContract {
  void onInsertUserInterestRouteCategoryComplete(
      List<InsertUserInterestRouteCategory> items);
  void onInsertUserInterestRouteCategoryError();
}

class InserUserInterestRouteCategoryListPresenter {
  InsertUserInterestRouteCategoryListViewContract _viewContract;
  InsertUserInterestRouteCategoryRepository _repository;

  InserUserInterestRouteCategoryListPresenter(this._viewContract) {
    _repository = new Injector().insertUserInterestRouteCategoryRepository;
  }

  void loadServerResponse(String categoryName) {
    _repository
        .sendRouteCategory(categoryName)
        .then(
            (sR) => _viewContract.onInsertUserInterestRouteCategoryComplete(sR))
        .catchError((onError) =>
            _viewContract.onInsertUserInterestRouteCategoryError());
  }
}
