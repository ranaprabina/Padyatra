import 'dart:async';

class RouteDetails {
  String routeId;
  String routeName;
  String image;
  String routeDescription;
  var length;
  String duration;
  String category;
  int conservationalPermit;
  int timsPermit;
  int restrictedAreaPermit;
  int altitude;
  String documentsDetils;
  bool isBookmarked;
  List<WayPoints> wayPoints;

  RouteDetails(
      {this.routeId,
      this.routeName,
      this.image,
      this.routeDescription,
      this.length,
      this.duration,
      this.category,
      this.conservationalPermit,
      this.timsPermit,
      this.restrictedAreaPermit,
      this.altitude,
      this.documentsDetils,
      this.isBookmarked,
      this.wayPoints});

  RouteDetails.toMap(Map<String, dynamic> map)
      : routeId = map['route_id'],
        routeName = map['route_name'],
        image = map['image'],
        routeDescription = map['description'],
        length = map['route_length'],
        duration = map['duration'],
        category = map['category'],
        conservationalPermit = map['c_n_permit'],
        timsPermit = map['tims_permit'],
        restrictedAreaPermit = map['r_a_permit'],
        altitude = map['route_altitude'],
        documentsDetils = map['documentInformation'],
        isBookmarked = map['isBookmarked'],
        wayPoints = List<WayPoints>.from(
            map['wayPoints'].map((wP) => new WayPoints.fromMap(wP))).toList();
}

class WayPoints {
  int wayId;
  String routeId;
  String wayPointName;
  String wayPointDescription;
  double wayLatitude;
  double wayLongitude;
  WayPoints({
    this.wayId,
    this.routeId,
    this.wayPointName,
    this.wayPointDescription,
    this.wayLatitude,
    this.wayLongitude,
  });
  WayPoints.fromMap(Map<String, dynamic> map)
      : wayId = map['way_id'],
        routeId = map['route_id'],
        wayPointName = map['way_point_name'],
        wayPointDescription = map["way_point_description"],
        wayLatitude = map['way_latitude'].toDouble(),
        wayLongitude = map['way_longitude'].toDouble();
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
