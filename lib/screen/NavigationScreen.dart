import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/presenter/get_route_coordinates_presenter.dart';
import '../control_sizes.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    implements GetRouteCoordinatesListViewContract {
  GetRouteCoordinates getRouteCoordinates;
  GetRouteCoordinatesListPresenter _getRouteCoordinatesListPresenter;
  List<GetRouteCoordinates> _getRouteCoordinatesServerResponse;
  List<LatLng> _routeCoordinates = [];
  Set<Polyline> polyline = {};

  bool _isRoutePathAvailable;
  _NavigationScreenState() {
    _getRouteCoordinatesListPresenter =
        new GetRouteCoordinatesListPresenter(this);
  }

  GoogleMapController _mapController;
  Location location = new Location();
  static const LatLng _centre = const LatLng(28.2, 83.98);

  LatLng _lastMapPosition = _centre;
  static double currentLatitude;
  static double currentLongitude;
  bool _isLoading = true;
  final List<Circle> circle = [];

  void _createPolyLine(List<LatLng> routeCoordinates) {
    polyline.add(Polyline(
      polylineId: PolylineId('0'),
      points: routeCoordinates,
      visible: true,
      width: 5,
      color: Colors.red[600],
      startCap: Cap.roundCap,
      endCap: Cap.buttCap,
    ));
  }

  Future getCurrentLocation() async {
    location.onLocationChanged.listen(
      (currentLocation) {
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
    _isRoutePathAvailable = false;
    getCurrentLocation();
    _getRouteCoordinatesListPresenter.loadServerResponseCoordinates();
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
      floatingActionButton: MyFloatingActionButton(),
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
                        target: LatLng(currentLatitude, currentLongitude),
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
                      polylines: polyline,
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

  @override
  void onGetRouteCoordinatesComplete(List<GetRouteCoordinates> items) {
    setState(() {
      _getRouteCoordinatesServerResponse = items;
      var _coordinates =
          _getRouteCoordinatesServerResponse[0].coordinates.routeCoords;

      if (_routeCoordinates.isEmpty) {
        for (int index = 0; index < _coordinates.length; index++) {
          _routeCoordinates.add(LatLng(
              _coordinates[index].latitude, _coordinates[index].longitude));
        }
        setState(() {
          _isRoutePathAvailable = true;
        });
      } else {
        setState(() {
          _isRoutePathAvailable = false;
          _routeCoordinates = [];
        });
      }
      _isRoutePathAvailable
          ? _createPolyLine(_routeCoordinates)
          : _createPolyLine(_routeCoordinates);
    });
  }

  @override
  void onGetRouteCoordinatesError() {
    throw new FetchDataException1();
  }
}

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;
  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            backgroundColor: Hexcolor('#9EABE4'),
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        margin:
                            const EdgeInsets.only(top: 0, left: 0, right: 0),
                        height: displayHeight(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: double.infinity,
                        child: BottomSheetWidget(),
                      ));
              showFoatingActionButton(false);
              bottomSheetController.closed.then((value) {
                showFoatingActionButton(true);
              });
            },
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 15, right: 15),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: displayHeight(context) * 0.12,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: displayHeight(context) * 0.5,
                          width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'est duration',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: displayHeight(context) * 0.05,
                                  child: Text(
                                    'total time taken to reach final destination',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '2 days',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.09,
                        ),
                        Container(
                          height: displayHeight(context) * 0.5,
                          width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'est duration',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: displayHeight(context) * 0.05,
                                  child: Text(
                                    'total time taken to reach final destination',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '2 days',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Container(
                    height: displayHeight(context) * 0.12,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: displayHeight(context) * 0.5,
                          width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'est duration',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: displayHeight(context) * 0.05,
                                  child: Text(
                                    'total time taken to reach final destination',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '2 days',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: displayWidth(context) * 0.09),
                        Container(
                          height: displayHeight(context) * 0.5,
                          width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'est duration',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: displayHeight(context) * 0.05,
                                  child: Text(
                                    'total time taken to reach final destination',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '2 days',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
