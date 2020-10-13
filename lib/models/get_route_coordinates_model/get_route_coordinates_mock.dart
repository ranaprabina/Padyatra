import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';

class MockGetRouteCoordinates implements GetRouteCoordinatesRepository {
  @override
  Future<List<GetRouteCoordinates>> getRouteCoordinates() {
    return new Future.value(serverResponse);
  }
}

var serverResponse = <GetRouteCoordinates>[
  new GetRouteCoordinates(
    routeId: "Mardi",
    coordinates: Coordinates(
      routeCoords: [
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
        {"lat": '26.8760', "lng": '84.23423423'},
      ],
    ),
  ),
];
