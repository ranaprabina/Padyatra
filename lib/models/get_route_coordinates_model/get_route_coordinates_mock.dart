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
    coordinates: Coordinates(routeCoords: [
      RouteCoords(
        latitude: 28.2175128,
        longitude: 83.9825729,
      ),
      RouteCoords(
        latitude: 28.217458447601267,
        longitude: 83.98269474506378,
      ),
      RouteCoords(
        latitude: 28.217399952105097,
        longitude: 83.98267529904842,
      ),
      RouteCoords(
        latitude: 28.217458447601267,
        longitude: 83.98264613002539,
      ),
      RouteCoords(
        latitude: 28.217102451787685,
        longitude: 83.98258309811354,
      ),
      RouteCoords(
        latitude: 28.21695384903471,
        longitude: 83.98254085332155,
      ),
      RouteCoords(
        latitude: 28.21693937281114,
        longitude: 83.98251369595528,
      ),
      RouteCoords(
        latitude: 28.2169751202168,
        longitude: 83.98239333182573,
      ),
      RouteCoords(
        latitude: 28.217042478932157,
        longitude: 83.982172049582,
      ),
      RouteCoords(
        latitude: 28.217113678229808,
        longitude: 83.98194741457701,
      ),
      RouteCoords(
        latitude: 28.21735238756185,
        longitude: 83.98134358227253,
      ),
      RouteCoords(
        latitude: 28.217564507535347,
        longitude: 83.98085474967957,
      ),
      RouteCoords(
        latitude: 28.21814946015363,
        longitude: 83.98068610578775,
      ),
      RouteCoords(
        latitude: 28.21858019594207,
        longitude: 83.98047287017107,
      ),
      RouteCoords(
        latitude: 28.21886794302464,
        longitude: 83.97940300405025,
      ),
      RouteCoords(
        latitude: 28.21891550689277,
        longitude: 83.97841963917017,
      ),
      RouteCoords(
        latitude: 28.219012111702543,
        longitude: 83.97787246853113,
      ),
      RouteCoords(
        latitude: 28.219201480510336,
        longitude: 83.97742353379726,
      ),
      RouteCoords(
        latitude: 28.22077343544781,
        longitude: 83.97794388234615,
      ),
      RouteCoords(
        latitude: 28.223062049378004,
        longitude: 83.97888131439686,
      ),
      RouteCoords(
        latitude: 28.2248082403288,
        longitude: 83.98024287074804,
      ),
      RouteCoords(
        latitude: 28.225511612507773,
        longitude: 83.98063447326422,
      ),
      RouteCoords(
        latitude: 28.22705422942339,
        longitude: 83.98098215460777,
      ),
      RouteCoords(
        latitude: 28.228313534210056,
        longitude: 83.98131474852562,
      ),
      RouteCoords(
        latitude: 28.23113783229253,
        longitude: 83.98227229714394,
      ),
      RouteCoords(
        latitude: 28.233529609586544,
        longitude: 83.98286707699299,
      ),
      RouteCoords(
        latitude: 28.234505859951888,
        longitude: 83.98302264511585,
      ),
      RouteCoords(
        latitude: 28.234123336288995,
        longitude: 83.98429602384567,
      ),
      RouteCoords(
        latitude: 28.233898842998865,
        longitude: 83.9850477129221,
      ),
      RouteCoords(
        latitude: 28.233724269600753,
        longitude: 83.9856642857194,
      ),
      RouteCoords(
        latitude: 28.23153631786791,
        longitude: 83.98510605096817,
      ),
      RouteCoords(
        latitude: 28.23033672113284,
        longitude: 83.98479156196117,
      ),
      RouteCoords(
        latitude: 28.228717052140755,
        longitude: 83.98457765579224,
      ),
      RouteCoords(
        latitude: 28.2274952684226,
        longitude: 83.98462828248739,
      ),
      RouteCoords(
        latitude: 28.226296217080016,
        longitude: 83.98474227637053,
      ),
      RouteCoords(
        latitude: 28.22486495929872,
        longitude: 83.98469936102629,
      ),
      RouteCoords(
        latitude: 28.223775772561737,
        longitude: 83.98463666439056,
      ),
      RouteCoords(
        latitude: 28.222488349551575,
        longitude: 83.98436710238457,
      ),
      RouteCoords(
        latitude: 28.221209478234687,
        longitude: 83.9841253682971,
      ),
      RouteCoords(
        latitude: 28.220126162688263,
        longitude: 83.9838558062911,
      ),
      RouteCoords(
        latitude: 28.21972320313264,
        longitude: 83.98370325565338,
      ),
      RouteCoords(
        latitude: 28.219321719188997,
        longitude: 83.98403752595186,
      ),
      RouteCoords(
        latitude: 28.218239270776913,
        longitude: 83.9837109670043,
      ),
      RouteCoords(
        latitude: 28.216781611390285,
        longitude: 83.98313630372286,
      ),
      RouteCoords(
        latitude: 28.21688560396354,
        longitude: 83.98268803954124,
      ),
    ]
        // [
        //   {"lat": 28.2175128, "lng": 83.9825729},
        //   {"lat": 28.217458447601267, "lng": 83.98269474506378},
        //   {"lat": 28.217399952105097, "lng": 83.98267529904842},
        //   {"lat": 28.217290346821414, "lng": 83.98264613002539},
        //   {"lat": 28.217102451787685, "lng": 83.98258309811354},
        //   {"lat": 28.21695384903471, "lng": 83.98254085332155},
        //   {"lat": 28.21693937281114, "lng": 83.98251369595528},
        //   {"lat": 28.2169751202168, "lng": 83.98239333182573},
        //   {"lat": 28.217042478932157, "lng": 83.982172049582},
        //   {"lat": 28.217113678229808, "lng": 83.98194741457701},
        //   {"lat": 28.21735238756185, "lng": 83.98134358227253},
        //   {"lat": 28.217564507535347, "lng": 83.98085474967957},
        //   {"lat": 28.21814946015363, "lng": 83.98068610578775},
        //   {"lat": 28.21858019594207, "lng": 83.98047287017107},
        //   {"lat": 28.21886794302464, "lng": 83.97940300405025},
        //   {"lat": 28.21891550689277, "lng": 83.97841963917017},
        //   {"lat": 28.219012111702543, "lng": 83.97787246853113},
        //   {"lat": 28.219201480510336, "lng": 83.97742353379726},
        //   {"lat": 28.22077343544781, "lng": 83.97794388234615},
        //   {"lat": 28.223062049378004, "lng": 83.97888131439686},
        //   {"lat": 28.2248082403288, "lng": 83.98024287074804},
        //   {"lat": 28.225511612507773, "lng": 83.98063447326422},
        //   {"lat": 28.22705422942339, "lng": 83.98098215460777},
        //   {"lat": 28.228313534210056, "lng": 83.98131474852562},
        //   {"lat": 28.23113783229253, "lng": 83.98227229714394},
        //   {"lat": 28.233529609586544, "lng": 83.98286707699299},
        //   {"lat": 28.234505859951888, "lng": 83.98302264511585},
        //   {"lat": 28.234123336288995, "lng": 83.98429602384567},
        //   {"lat": 28.233898842998865, "lng": 83.9850477129221},
        //   {"lat": 28.233724269600753, "lng": 83.9856642857194},
        //   {"lat": 28.23153631786791, "lng": 83.98510605096817},
        //   {"lat": 28.23033672113284, "lng": 83.98479156196117},
        //   {"lat": 28.228717052140755, "lng": 83.98457765579224},
        //   {"lat": 28.2274952684226, "lng": 83.98462828248739},
        //   {"lat": 28.226296217080016, "lng": 83.98474227637053},
        //   {"lat": 28.22486495929872, "lng": 83.98469936102629},
        //   {"lat": 28.223775772561737, "lng": 83.98463666439056},
        //   {"lat": 28.222488349551575, "lng": 83.98436710238457},
        //   {"lat": 28.221209478234687, "lng": 83.9841253682971},
        //   {"lat": 28.220126162688263, "lng": 83.9838558062911},
        //   {"lat": 28.21972320313264, "lng": 83.98370325565338},
        //   {"lat": 28.219321719188997, "lng": 83.98403752595186},
        //   {"lat": 28.218239270776913, "lng": 83.9837109670043},
        //   {"lat": 28.216781611390285, "lng": 83.98313630372286},
        //   {"lat": 28.21688560396354, "lng": 83.98268803954124},
        // ],
        ),
  ),
];
