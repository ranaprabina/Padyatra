import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyatra/models/completed_route_model/completed_route_data.dart';
import 'package:padyatra/models/day_performance_model/day_performance_data.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/presenter/day_performance_presenter.dart';
import 'package:padyatra/presenter/get_route_coordinates_presenter.dart';
import 'package:padyatra/services/DistanceCalculation.dart';

class CompletedRouteDetails extends StatefulWidget {
  final completedRoute;
  final userId;
  const CompletedRouteDetails({Key key, this.completedRoute, this.userId})
      : super(key: key);

  @override
  _CompletedRouteDetailsState createState() => _CompletedRouteDetailsState();
}

class _CompletedRouteDetailsState extends State<CompletedRouteDetails>
    implements
        GetRouteCoordinatesListViewContract,
        DayPerformanceListViewContract {
  GoogleMapController _mapController;
  Set<Polyline> polyline = {};
  final List<Circle> circle = [];
  Set<Marker> reachedPointsMarkers = {};

  GetRouteCoordinatesListPresenter _getRouteCoordinatesListPresenter;
  List<GetRouteCoordinates> _getRouteCoordinatesServerResponse;
  List<LatLng> _routeCoordinates = [];

  bool _isRoutePathAvailable;
  bool _isMarkersAvailable;
  double routeTotalDistance;

  DayPerformance dayPerformance;
  DayPerformanceListPresenter _dayPerformanceListPresenter;
  List<DayPerformance> _dayPerformanceServerResponse;

  PageController _pageController;
  int prevPage;

  _CompletedRouteDetailsState() {
    _getRouteCoordinatesListPresenter =
        new GetRouteCoordinatesListPresenter(this);
    _dayPerformanceListPresenter = new DayPerformanceListPresenter(this);
  }
  @override
  void initState() {
    _isRoutePathAvailable = false;
    _isMarkersAvailable = false;
    CompletedRoute completedRoute = widget.completedRoute;
    _getRouteCoordinatesListPresenter
        .loadServerResponseCoordinates(completedRoute.routeId.toString());
    _dayPerformanceListPresenter.getDayPerformance(
        completedRoute.routeId.toString(), widget.userId.toString());
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  void drawRoutePath() {
    setState(() {
      _routeCoordinates.isNotEmpty || _routeCoordinates != null
          ? _isRoutePathAvailable = true
          : _isRoutePathAvailable = false;

      _isRoutePathAvailable
          ? _createPolyLine(_routeCoordinates)
          : _createPolyLine(_routeCoordinates);
    });
  }

  void _createPolyLine(List<LatLng> routeCoordinates) {
    polyline.add(Polyline(
      polylineId: PolylineId('0'),
      points: routeCoordinates,
      visible: true,
      width: 5,
      color: Colors.green[600],
      startCap: Cap.roundCap,
      endCap: Cap.buttCap,
    ));
  }

  moveCamera() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              _dayPerformanceServerResponse[_pageController.page.toInt()]
                  .lattitudeReached,
              _dayPerformanceServerResponse[_pageController.page.toInt()]
                  .longitudeReached),
          zoom: 18.0,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  Widget _reachePointsList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 210.0,
            width: Curves.easeInOut.transform(value) * 475.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          moveCamera();
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 300.0,
                // width: 275.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: "Point no : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Reached latitude : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${_dayPerformanceServerResponse[index].lattitudeReached.toString()}",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Reached longitude : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${_dayPerformanceServerResponse[index].longitudeReached.toString()}",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                          Text(
                            _dayPerformanceServerResponse[index]
                                        .trekkingCompleted ==
                                    0
                                ? "trekking was not completed."
                                : "trekking was completed",
                            style: TextStyle(
                              color: _dayPerformanceServerResponse[index]
                                          .trekkingCompleted ==
                                      0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _isMarkersAvailable && _isRoutePathAvailable
                ? GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_routeCoordinates[0].latitude,
                          _routeCoordinates[0].longitude),
                      zoom: 14.0,
                    ),
                    onTap: (coordinate) {
                      setState(
                        () {
                          _mapController.animateCamera(
                              CameraUpdate.newLatLng(coordinate));
                        },
                      );
                    },
                    mapType: MapType.normal,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    polylines: polyline,
                    markers: reachedPointsMarkers,
                  )
                : new SpinKitChasingDots(
                    color: Colors.green,
                  ),
          ),
          _isMarkersAvailable
              ? Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _dayPerformanceServerResponse.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _reachePointsList(index);
                      },
                    ),
                  ),
                )
              : Container()
        ],
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
          routeTotalDistance =
              distanceCalculation(0, _routeCoordinates).roundToDouble();
        });
      } else {
        setState(() {
          _routeCoordinates = [];
        });
      }
      drawRoutePath();
    });
  }

  @override
  void onGetRouteCoordinatesError() {
    setState(() {
      _routeCoordinates = [];
    });
    try {
      throw new FetchDataException1(
          "Error_Occured: Unable to fetch Route geo coordinates.");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onLoadComplete(List<DayPerformance> items) {
    setState(() {
      _dayPerformanceServerResponse = items;
      if (_dayPerformanceServerResponse.isNotEmpty ||
          _dayPerformanceServerResponse != null) {
        _dayPerformanceServerResponse.forEach((element) {
          LatLng reahedPointMarkerCoords =
              LatLng(element.lattitudeReached, element.longitudeReached);
          reachedPointsMarkers.add(Marker(
            markerId: MarkerId(element.dayId.toString()),
            position: reahedPointMarkerCoords,
            draggable: false,
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
        _isMarkersAvailable = true;
      } else {
        reachedPointsMarkers = {};
        _isMarkersAvailable = false;
      }
    });
  }

  @override
  void onLoadError() {
    setState(() {});
  }

  @override
  void onStoreComplete(List<DayPerformance> itens) {}

  @override
  void onStoreError() {}
}
