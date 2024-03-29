import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:padyatra/models/day_performance_model/day_performance_data.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/presenter/day_performance_presenter.dart';
import 'package:padyatra/screen/NoConnection.dart';
import 'package:padyatra/services/DistanceCalculation.dart';
import 'package:padyatra/services/GeoFencing.dart';
import 'package:padyatra/services/NavgationData.dart';
import '../control_sizes.dart';

class NavigationScreen extends StatefulWidget {
  final userID;
  final routeID;
  final List<WayPoints> wayPoints;
  final routeTotalDistance;
  final routeCoordinates;

  const NavigationScreen({
    Key key,
    this.wayPoints,
    this.routeID,
    this.userID,
    this.routeTotalDistance,
    this.routeCoordinates,
  }) : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    implements DayPerformanceListViewContract {
  DayPerformance dayPerformance;
  DayPerformanceListPresenter _dayPerformanceListPresenter;
  List<DayPerformance> _dayPerformanceServerResponse;
  List<LatLng> _routeCoordinates = [];
  Set<Polyline> polyline = {};
  var listenLocationData;
  bool _isRoutePathAvailable;
  bool _isCheckInPostReached;
  bool _isCheckOutPostReached;
  bool _isTrekkingCompleted;
  String trekkingCompleted;
  String geofenceRadiusMeter = "100";
  Timer _storeDataTimer;
  Timer _checkWayPointsReachedtimer;
  GoogleMapController _mapController;
  Location location = new Location();
  LatLng _centre;
  LatLng _lastMapPosition;
  static double currentLatitude;
  static double currentLongitude;
  bool _isLoading;
  final List<Circle> circle = [];
  Set<Marker> wayPointMarkers = {};
  double routeTotalDistance;
  bool insideGeofence;
  int calculateRemainigDistanceFromThisPoint;
  double remainingDistance;
  bool wayPointsAvailable;
  List<WayPoints> wayPoint;
  bool hasConnection;
  var connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  checkConnection() async {
    connectivityResult = await (_connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            hasConnection = true;
          });
        } else {
          setState(() {
            hasConnection = false;
          });
        }
      } on SocketException catch (_) {
        setState(() {
          hasConnection = false;
        });
      }
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  _NavigationScreenState() {
    _dayPerformanceListPresenter = new DayPerformanceListPresenter(this);
  }
  void checkAvailableWayPoints() {
    if (widget.wayPoints.isNotEmpty) {
      setState(() {
        wayPointsAvailable = true;
        wayPoint = widget.wayPoints;
      });
    } else {
      setState(() {
        wayPointsAvailable = false;
        wayPoint = [];
      });
    }
  }

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
    listenLocationData = location.onLocationChanged.listen(
      (currentLocation) {
        currentLatitude = currentLocation.latitude;
        currentLongitude = currentLocation.longitude;
        if (currentLatitude != null && currentLongitude != null) {
          setState(() {
            _centre = LatLng(currentLatitude, currentLongitude);
            _lastMapPosition = _centre;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = true;
          });
        }
      },
    );
  }

  updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        // case ConnectivityResult.none:
        setState(() {
          print("connection status changed to true");
          hasConnection = true;
        });
        break;
      default:
        setState(() {
          print("connection status changed to false");
          hasConnection = false;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isRoutePathAvailable = false;
    _isCheckInPostReached = false;
    _isCheckOutPostReached = false;
    _isTrekkingCompleted = false;
    _routeCoordinates = widget.routeCoordinates;
    checkConnection();
    drawRoutePath();
    getCurrentLocation();
    checkAvailableWayPoints();
    _createWayPointsMarkers();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void drawRoutePath() {
    setState(() {
      _routeCoordinates.isNotEmpty && _routeCoordinates != null
          ? _isRoutePathAvailable = true
          : _isRoutePathAvailable = false;

      _isRoutePathAvailable
          ? _createPolyLine(_routeCoordinates)
          : _createPolyLine(_routeCoordinates);
    });
  }

  void _createWayPointsMarkers() {
    if (!wayPointsAvailable) {
      wayPointMarkers = {};
    } else {
      wayPoint.forEach((element) {
        LatLng wayPointsMarkerCoords =
            LatLng(element.wayLatitude, element.wayLongitude);
        print(element.wayPointName);
        wayPointMarkers.add(Marker(
          markerId: MarkerId(element.wayId.toString()),
          position: wayPointsMarkerCoords,
          draggable: false,
          infoWindow: InfoWindow(
            title: element.wayPointName,
            snippet: element.wayPointDescription,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    }
  }

  bool checkTrekkingCompleted(String latitude, String longitude) {
    bool response =
        GeoFencing().startGeofencing(latitude, longitude, geofenceRadiusMeter);
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  storeDayPerformance() {
    if (hasConnection) {
      _isTrekkingCompleted ? trekkingCompleted = "1" : trekkingCompleted = "0";
      _dayPerformanceListPresenter.sendDayPerformance(
          widget.userID,
          widget.routeID,
          currentLatitude.toString(),
          currentLongitude.toString(),
          trekkingCompleted);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("no internet connection"),
      ));
    }
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
            radius: 10,
            zIndex: 1,
            strokeWidth: 3,
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
            radius: 100,
            visible: true,
            strokeWidth: 5,
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
      heroTag: "currentLocationButton",
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.green,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  navigationErrorWidget() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          title: Text(
            "Navigation Error",
            style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 20,
            ),
          ),
          content: new Text(
            "Unable to find starting point",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 15,
            ),
          ),
          actions: [
            new MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              // color: Color.fromRGBO(49, 39, 79, 1),
              color: Colors.green,
              child: Text(
                'ok',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  checkWaypointsReached() async {
    bool checkInPostState = await NavigationData().checkInPostReachedData();
    bool checkOutPostState = await NavigationData().checkOutPostReachedData();
    print(
        "In checkWayPointReached checkInPostState data is : $checkInPostState");
    print(
        "In checkWayPointReached checkOutPostState data is : $checkOutPostState");
    if (wayPointsAvailable) {
      wayPoint.forEach(
        (element) {
          if (!checkInPostState) {
            if (element.wayPointDescription == "Check-in Post") {
              if (GeoFencing().startGeofencing(element.wayLatitude.toString(),
                  element.wayLongitude.toString(), geofenceRadiusMeter)) {
                print("Entered inside geofencing area\n");
                setState(() {
                  _isCheckInPostReached = true;
                  print("sending checkInPostReaced data to store:");
                  NavigationData().holdNavigationData(_isCheckInPostReached);
                  print("checkInPostReached data stored");
                });
              } else {
                setState(() {
                  _isCheckInPostReached = false;
                });
              }
              _isCheckInPostReached
                  ? wayPointReachedDialogWidget(
                      GeoFencing().stopGeoFencing(),
                      element.wayPointDescription,
                      "don't forget to show trekking permits.")
                  : Container();
            }
          } else {
            if (!checkOutPostState) {
              if (element.wayPointDescription == "Check-out Post") {
                if (GeoFencing().startGeofencing(element.wayLatitude.toString(),
                    element.wayLongitude.toString(), geofenceRadiusMeter)) {
                  print("Entered inside geofencing area for checkOutPostState");
                  setState(() {
                    _isCheckOutPostReached = true;
                    print("sending checkOutPostReached data to store:");

                    NavigationData()
                        .holdCheckOutPostReachedData(_isCheckOutPostReached);
                    print("checkOutPostReached data stored");
                  });
                } else {
                  setState(() {
                    _isCheckOutPostReached = false;
                  });
                }
                _isCheckOutPostReached
                    ? wayPointReachedDialogWidget(
                        GeoFencing().stopGeoFencing(),
                        element.wayPointDescription,
                        "don't forget to check-out")
                    : Container();
              }
            }
          }
        },
      );
      if (checkOutPostState == true && checkInPostState == true) {
        bool trekCompletedResponse = checkTrekkingCompleted(
          wayPoint[wayPoint.length - 1].wayLongitude.toString(),
          wayPoint[wayPoint.length - 1].wayLongitude.toString(),
        );
        print("Trekking Completed Response is : $trekCompletedResponse");
        if (trekCompletedResponse) {
          setState(() {
            GeoFencing().stopGeoFencing();
            _isTrekkingCompleted = true;
          });
        } else {
          setState(() {
            _isTrekkingCompleted = false;
          });
        }
        _isTrekkingCompleted
            ? trekkingCompletedMessageWidget(
                "Congratulation",
                "you've completed trekking in this route.",
                "store your progress.",
              )
            : Container();
      }
    } else {
      navigationErrorWidget();
    }
  }

  wayPointReachedDialogWidget(var function, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          title: Text(
            "$title Reached",
            style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 20,
            ),
          ),
          content: new Text(
            message,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 15,
            ),
          ),
          actions: [
            new MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              onPressed: () {
                setState(() {
                  bool response = function;
                  if (response) {
                    setState(() {
                      print("checking waypoints reached or not");
                      checkWaypointsReached();
                      Navigator.of(context).pop();
                    });
                  } else {
                    print("unable to stop geofencing service");
                    print(response);
                  }
                });
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              // color: Color.fromRGBO(49, 39, 79, 1),
              color: Colors.green,
              child: Text(
                'ok',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
            new MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              // color: Color.fromRGBO(49, 39, 79, 1),
              color: Colors.green,
              child: Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  trekkingCompletedMessageWidget(String title, String message, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.0,
              title: Container(
                padding: EdgeInsets.only(top: 35),
                child: Center(
                  child: new Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$message \n",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "\n$status",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                new MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      GeoFencing().stopGeoFencing();

                      if (_isTrekkingCompleted) {
                        _isTrekkingCompleted
                            ? trekkingCompleted = "1"
                            : trekkingCompleted = "0";
                        if (hasConnection) {
                          _dayPerformanceListPresenter.sendDayPerformance(
                              widget.userID,
                              widget.routeID,
                              currentLatitude.toString(),
                              currentLatitude.toString(),
                              trekkingCompleted);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("no internet connection"),
                          ));
                        }
                      }
                      if (_checkWayPointsReachedtimer.isActive) {
                        print(_checkWayPointsReachedtimer);
                        _checkWayPointsReachedtimer.cancel();
                      }
                    });
                  },
                  height: displayHeight(context) * 0.05,
                  minWidth: displayWidth(context) * 0.35,
                  // color: Color.fromRGBO(49, 39, 79, 1),
                  color: Colors.green,
                  child: Text(
                    'ok',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                new MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  height: displayHeight(context) * 0.05,
                  minWidth: displayWidth(context) * 0.35,
                  // color: Color.fromRGBO(49, 39, 79, 1),
                  color: Colors.green,
                  child: Text(
                    'cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: displayHeight(context) / 5,
              left: displayWidth(context) - 250,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.tag_faces,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    listenLocationData.cancel();
    GeoFencing().stopGeoFencing();
    NavigationData().deleteCheckInPostReachedData();
    NavigationData().deleteCheckOutPostReachedData();
    try {
      _connectivitySubscription.cancel();
      if (_checkWayPointsReachedtimer.isActive) {
        _checkWayPointsReachedtimer.cancel();
      }
      if (_storeDataTimer.isActive) {
        _storeDataTimer.cancel();
      }
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return hasConnection == false
        ? NoConnectionScreen(
            screenName: NavigationScreen(
              userID: widget.userID,
              routeID: widget.routeID,
              wayPoints: widget.wayPoints,
              routeTotalDistance: widget.routeTotalDistance,
              routeCoordinates: _routeCoordinates,
            ),
            method: "pushReplacement",
          )
        : Scaffold(
            floatingActionButton: MyFloatingActionButton(
                routeTotalDistance: widget.routeTotalDistance,
                routeCoordinates: _routeCoordinates),
            body: Stack(
              children: [
                _isLoading && _isRoutePathAvailable
                    ? Center(
                        child: SpinKitChasingDots(
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _isRoutePathAvailable
                                ? LatLng(_routeCoordinates[0].latitude,
                                    _routeCoordinates[0].longitude)
                                : wayPointsAvailable
                                    ? LatLng(wayPoint[0].wayLatitude,
                                        wayPoint[0].wayLongitude)
                                    : LatLng(currentLatitude, currentLongitude),
                            zoom: wayPointMarkers.isEmpty ? 10.0 : 12.0,
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
                          markers: wayPointMarkers,
                        ),
                      ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 25,
                  right: MediaQuery.of(context).size.width - 140,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () async {
                      if (wayPointsAvailable && _isRoutePathAvailable) {
                        _mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _routeCoordinates[0].latitude.toDouble(),
                                _routeCoordinates[0].longitude.toDouble(),
                              ),
                              bearing: 0.0,
                              tilt: 0.0,
                              zoom: 25,
                            ),
                          ),
                        );

                        //stores initial data when trekking starts
                        storeDayPerformance();

                        //stores periodically
                        _storeDataTimer = Timer.periodic(
                          Duration(hours: 1),
                          (timer) {
                            setState(() {
                              storeDayPerformance();
                            });
                          },
                        );

                        checkWaypointsReached();
                        _checkWayPointsReachedtimer = Timer.periodic(
                          Duration(hours: 1),
                          (timer) {
                            setState(() {
                              checkWaypointsReached();
                            });
                          },
                        );
                      } else {
                        !_isRoutePathAvailable
                            ? Fluttertoast.showToast(
                                msg: "route path not available",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              )
                            : Fluttertoast.showToast(
                                msg: "way points not available",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                      }
                      // await checkWaypointsReached();
                    },
                    child: Text("start navigation"),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 19,
                  left: MediaQuery.of(context).size.width - 90,
                  child: currentLocationButton(
                      _gotoCurrentLocation, Icons.location_searching),
                ),
              ],
            ),
          );
  }

  @override
  void onStoreComplete(List<DayPerformance> itens) {
    _dayPerformanceServerResponse = itens;
    dayPerformance = _dayPerformanceServerResponse[0];
    if (dayPerformance.serverResponse.isNotEmpty &&
        dayPerformance.serverResponse == "Insertion_Success") {
      // NavigationData().deleteCheckInPostReachedData();
      // NavigationData().deleteCheckOutPostReachedData();
      Fluttertoast.showToast(
        msg: dayPerformance.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    if (dayPerformance.serverResponse.isNotEmpty &&
        dayPerformance.serverResponse == "Already_exists") {
      Fluttertoast.showToast(
        msg: dayPerformance.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // NavigationData().deleteCheckInPostReachedData();
      // NavigationData().deleteCheckOutPostReachedData();
    }
  }

  @override
  void onStoreError() {
    try {
      Fluttertoast.showToast(
        msg: "error occured",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.of(context).pop();
      throw new FetchDataException(
          "Error Occured: Unable to store trekking completion data into database.");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onLoadComplete(List<DayPerformance> items) {}

  @override
  void onLoadError() {}
}

class MyFloatingActionButton extends StatefulWidget {
  final routeTotalDistance;
  final routeCoordinates;

  const MyFloatingActionButton(
      {Key key, this.routeTotalDistance, this.routeCoordinates})
      : super(key: key);
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;
  bool _checkInPostStatus;
  bool _checkOutPostStatus;
  @override
  void initState() {
    super.initState();
    _checkInPostStatus = false;
    _checkOutPostStatus = false;
    this.checkInPostStatus();
    this.checkOutPostStatus();
  }

  checkInPostStatus() async {
    if (await NavigationData().checkInPostReachedData()) {
      print("check in status $_checkInPostStatus");
      setState(() {
        _checkInPostStatus = true;
      });
    } else {
      setState(() {
        _checkInPostStatus = false;
      });
    }
  }

  checkOutPostStatus() async {
    if (await NavigationData().checkOutPostReachedData()) {
      setState(() {
        _checkOutPostStatus = true;
      });
    } else {
      _checkOutPostStatus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return showFab
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 150.0, vertical: 20.0),
            child: FloatingActionButton(
              heroTag: "navigationStatusButton",
              child: Icon(Icons.arrow_upward),
              // backgroundColor: Hexcolor('#9EABE4'),
              backgroundColor: Colors.green[900],
              onPressed: () {
                checkInPostStatus();
                checkOutPostStatus();

                var bottomSheetController = showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          margin:
                              const EdgeInsets.only(top: 0, left: 0, right: 0),
                          height: displayHeight(context) * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          width: double.infinity,
                          child: BottomSheetWidget(
                            checkInPostStatus: _checkInPostStatus,
                            checkOutPostStatus: _checkOutPostStatus,
                            routeTotalDistance: widget.routeTotalDistance,
                            routeCoordinates: widget.routeCoordinates,
                          ),
                        ));
                showFoatingActionButton(false);
                bottomSheetController.closed.then((value) {
                  showFoatingActionButton(true);
                });
              },
            ),
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
  final checkInPostStatus;
  final checkOutPostStatus;
  final trekkingCompletionStatus;
  final routeTotalDistance;
  final routeCoordinates;

  const BottomSheetWidget(
      {Key key,
      this.checkInPostStatus,
      this.checkOutPostStatus,
      this.trekkingCompletionStatus,
      this.routeTotalDistance,
      this.routeCoordinates})
      : super(key: key);
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var routeTotalDistance;
  var routeCoordinates;
  bool insideGeofence;
  double remainingDistance;
  int calculateRemainigDistanceFromThisPoint;

  @override
  void initState() {
    super.initState();
    routeTotalDistance = widget.routeTotalDistance;
    routeCoordinates = widget.routeCoordinates;
    calculateRemainingDisatance();
  }

  void calculateRemainingDisatance() {
    if (routeTotalDistance != null) {
      for (int i = 0; i < routeCoordinates.length; i++) {
        insideGeofence = GeoFencing().startGeofencing(
            routeCoordinates[i].latitude.toString(),
            routeCoordinates[i].longitude.toString(),
            "100");
        if (insideGeofence) {
          calculateRemainigDistanceFromThisPoint = i;
          setState(() {
            remainingDistance = distanceCalculation(
                    calculateRemainigDistanceFromThisPoint, routeCoordinates)
                .roundToDouble();
            print("remaining distance is : $remainingDistance");
          });
          break;
        } else {
          GeoFencing().stopGeoFencing();
          print("Unable to enter goefence and calculate remaining distance");
          continue;
        }
      }
    } else {
      setState(() {
        routeTotalDistance = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.only(top: 0, left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    // height: displayHeight(context) * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: displayHeight(context) * 0.2,
                          // width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    // alignment: Alignment.topLeft,
                                    child: Text(
                                  'Check In Post Status',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Oswald",
                                  ),
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
                                    widget.checkInPostStatus
                                        ? "check in post reached"
                                        : 'check in post not reached',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Noto Sans",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Oswald",
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        Container(
                          height: displayHeight(context) * 0.2,
                          // width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    // alignment: Alignment.topLeft,
                                    child: Text(
                                  'Check Out Post Status',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Oswald",
                                  ),
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
                                    widget.checkOutPostStatus
                                        ? "check out post reached"
                                        : 'check out post not reached',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Noto Sans",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Oswald",
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Container(
                    // height: displayHeight(context) * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: displayHeight(context) * 0.2,
                          // width: displayWidth(context) * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                    // alignment: Alignment.topLeft,
                                    child: Text(
                                  'Route Total Distance',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Oswald",
                                  ),
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
                                    routeTotalDistance != null
                                        ? "${routeTotalDistance.toInt().toString()} km"
                                        : "not available",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Noto Sans",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Oswald",
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: displayHeight(context) * 0.02),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: displayHeight(context) * 0.2,
                                // width: displayWidth(context) * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.green[900],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: Container(
                                          // alignment: Alignment.topLeft,
                                          child: Text(
                                        'Distance remaining to cover',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: "Oswald",
                                        ),
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
                                          remainingDistance != null
                                              ? "${remainingDistance.toInt().toString()} km"
                                              : "not available",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: "Noto Sans",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Oswald",
                                            ),
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
