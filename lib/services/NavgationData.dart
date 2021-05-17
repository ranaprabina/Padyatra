import 'package:shared_preferences/shared_preferences.dart';

class NavigationData {
  var checkInPostReached;
  var checkOutPostReached;
  holdNavigationData(var checkInPostReached) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    this.checkInPostReached =
        localStorage.setBool('checkInPostReached', checkInPostReached);
  }

  Future<bool> checkInPostReachedData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var checkInPostReachedState = localStorage.getBool('checkInPostReached');
    print(
        "In NavigationData.dart checkInPostReached data is : $checkInPostReachedState");
    if (checkInPostReachedState != null && checkInPostReachedState == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCheckInPostReachedData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var checkInPostReachedState = localStorage.getBool('checkInPostReached');
    print(
        "In NavigationData.dart CheckInPostReached data is : $checkInPostReachedState");
    if (checkInPostReachedState != null && checkInPostReachedState == true) {
      localStorage.remove('checkInPostReached');
      print("checkInPostReached data is deleted");
      return true;
    } else {
      return false;
    }
  }

  holdCheckOutPostReachedData(var checkOutPostReached) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    this.checkOutPostReached =
        localStorage.setBool('checkOutPostReached', checkOutPostReached);
  }

  Future<bool> checkOutPostReachedData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var checkOutPostReachedState = localStorage.getBool('checkOutPostReached');
    print(
        "In NavigationData.dart CheckOutPostReached data is : $checkOutPostReachedState");
    if (checkOutPostReachedState != null && checkOutPostReachedState == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCheckOutPostReachedData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var checkOutPostReachedState = localStorage.getBool('checkOutPostReached');
    print(
        "In NavigationData.dart CheckOutPostReached data is : $checkOutPostReachedState");
    if (checkOutPostReachedState != null && checkOutPostReachedState == true) {
      localStorage.remove('checkOutPostReached');
      print("checkOutPostReached data in deleted");

      return true;
    } else {
      return false;
    }
  }
}
