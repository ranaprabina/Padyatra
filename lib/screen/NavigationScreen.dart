import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  GoogleMapController _mapController;
  Location location = new Location();
  static const LatLng _centre = const LatLng(28.2, 83.98);

  LatLng _lastMapPosition = _centre;
  static double currentLatitude;
  static double currentLongitude;
  bool _isLoading = true;
  final List<Circle> circle = [];

  Future getCurrentLocation() async {
    location.onLocationChanged.listen(
      (currentLocation) {
        print("Current location is ${currentLocation.latitude}");
        print("Current location is ${currentLocation.longitude}");
        final latitude = currentLocation.latitude;
        final longitude = currentLocation.longitude;

        setState(
          () {
            currentLatitude = latitude;
            currentLongitude = longitude;
            _isLoading = false;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  static final CameraPosition _currentPostion = CameraPosition(
    bearing: 0.0,
    target: LatLng(currentLatitude, currentLongitude),
    tilt: 0.0,
    zoom: 18.0,
  );

  Future<void> _gotoCurrentLocation() async {
    final GoogleMapController controller = _mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPostion));
    setState(
      () {
        circle.add(
          Circle(
            circleId: CircleId('currentLocation'),
            radius: 30,
            zIndex: 1,
            visible: true,
            strokeColor: Colors.blue,
            center: LatLng(currentLatitude, currentLongitude),
            fillColor: Colors.blue.withAlpha(70),
          ),
        );
      },
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(
      () {
        _mapController = controller;
        circle.add(
          Circle(
            circleId: CircleId('currentLocation'),
            radius: 20,
            visible: true,
            zIndex: 1,
            strokeColor: Colors.blue,
            center: LatLng(currentLatitude, currentLongitude),
            fillColor: Colors.blue.withAlpha(70),
          ),
        );
      },
    );
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget currentLocationButton(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple[700],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(28.2, 83.98),
                        zoom: 16.0,
                      ),
                      onTap: (coordinate) {
                        setState(
                          () {
                            _mapController.animateCamera(
                                CameraUpdate.newLatLng(coordinate));
                            print(coordinate);
                          },
                        );
                      },
                      mapType: MapType.normal,
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: true,
                      circles: Set.from(circle),
                      onCameraMove: _onCameraMove,
                    ),
                  ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width - 70,
              child: currentLocationButton(
                  _gotoCurrentLocation, Icons.location_searching),
            ),
          ],
        ),
      ),
    );
  }
}
