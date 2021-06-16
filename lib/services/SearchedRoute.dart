import 'package:shared_preferences/shared_preferences.dart';

class UserSearchHistory {
  var routeName;
  storeUserSearchHistory(String routeName) async {
    List<String> searchedRouteList = await getSearchHistory();
    if (searchedRouteList == null) {
      searchedRouteList.add(routeName);
    } else {
      for (int index = 0; index < searchedRouteList.length; index++) {
        if (searchedRouteList[index] == routeName) {
          searchedRouteList.remove(routeName);
          return;
        }
      }
      searchedRouteList.add(routeName);
    }

    SharedPreferences searchStorage = await SharedPreferences.getInstance();
    this.routeName =
        searchStorage.setStringList('searchedRoute', searchedRouteList);
  }

  Future<List<String>> getSearchHistory() async {
    SharedPreferences searchStorage = await SharedPreferences.getInstance();
    List<String> result = searchStorage.getStringList('searchedRoute');
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }
}
