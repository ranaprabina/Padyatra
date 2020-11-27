import 'dart:async';

class RouteDetails {
  String routeId;
  String routeName;
  String image;
  String routeDescription;
  int length;
  String duration;
  String difficulty;
  int conservationalPermit;
  int timsPermit;
  int restrictedAreaPermit;
  int altitude;
  String documentsDetils;
  bool isBookmarked;

  RouteDetails(
      {this.routeId,
      this.routeName,
      this.image,
      this.routeDescription,
      this.length,
      this.duration,
      this.difficulty,
      this.conservationalPermit,
      this.timsPermit,
      this.restrictedAreaPermit,
      this.altitude,
      this.documentsDetils,
      this.isBookmarked});

  RouteDetails.toMap(Map<String, dynamic> map)
      : routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        routeDescription = map['description'],
        length = map['route_length'],
        duration = map['duration'],
        difficulty = map['difficulty'],
        conservationalPermit = map['c_n_permit'],
        timsPermit = map['tims_permit'],
        restrictedAreaPermit = map['r_a_permit'],
        altitude = map['route_altitude'],
        documentsDetils = map['documents_info'],
        isBookmarked = map['isBookmarked'];
}

abstract class RouteDetailsRepository {
  Future<List<RouteDetails>> fetchRouteDetails(
      String selectedRouteName, String userId);
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
