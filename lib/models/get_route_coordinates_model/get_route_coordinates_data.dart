import 'dart:convert';

class GetRouteCoordinates {
  String routeId;
  Coordinates coordinates;

  GetRouteCoordinates({
    this.routeId,
    this.coordinates,
  });

  GetRouteCoordinates.fromMap(Map<String, dynamic> map)
      : routeId = map['route_id'],
        coordinates = Coordinates.toMap(jsonDecode(map['coordinates']));
}

class Coordinates {
  List routeCoords;

  Coordinates({
    this.routeCoords,
  });
  Coordinates.toMap(Map<String, dynamic> map)
      : routeCoords = map['route_coords'];
}

// class RouteCoords {
//   double latitude;
//   double longitude;

//   RouteCoords({
//     this.latitude,
//     this.longitude,
//   });
//   RouteCoords.forMap(Map<String, dynamic> map)
//       : latitude = map['lat'].toDouble(),
//         longitude = map['lng'].toDouble();
// }

abstract class GetRouteCoordinatesRepository {
  Future<List<GetRouteCoordinates>> getRouteCoordinates();
}

class FetchDataException1 implements Exception {
  final _message;

  FetchDataException1([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
