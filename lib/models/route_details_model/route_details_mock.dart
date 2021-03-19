import 'package:padyatra/models/route_details_model/route_details_data.dart';
// import 'package:padyatra/screen/RouteDetails.dart';

class MockRouteDetails implements RouteDetailsRepository {
  @override
  Future<List<RouteDetails>> fetchRouteDetails(
      String selectedRouteName, String userId) {
    return new Future.value(routes);
  }
}

var routes = <RouteDetails>[
  new RouteDetails(
    routeId: "ABC Trek",
    routeName: "Annapurna Base Camp Trek",
    image: "Annapurna01.jpg",
    routeDescription:
        "The Setting at Annapurna Base Camp at 4130m is unique and incredibly spectacular, set amidst the majestic peaks of Annapurna (8091 m), Annapurna South (7219 m), Machapuchhre (6993 m) and Himchuli (6441 m). The Annapurna Base Camp Trek takes 7 to 12 days, depending on your itinerary and length of walking days. The itinerary presented here takes 12 days, starting from Nayapul( a 1.5 hours drive from Pokhara) and going north up to Ghorepani and the famous viewpoint at Poon Hill. From GHorepani You go eastward to Chomrong and then north again entering the Modi valley which leads up to the Base Camp.",
    length: 115,
    duration: "12",
    difficulty: "Hard",
    conservationalPermit: 1,
    timsPermit: 1,
    restrictedAreaPermit: 0,
    altitude: 4130,
    documentsDetils:
        "The following documents are required to get permits before starting trekking in this route",
    isBookmarked: true,
    wayPoints: [
      WayPoints(
        wayId: 55,
        routeId: "ABC Trek",
        wayPointName: 'WayPoint1',
        wayPointDescription: "this is a waypoint1",
        wayLatitude: 28.2175128,
        wayLongitude: 83.9825729,
      )
    ],
  ),
];
