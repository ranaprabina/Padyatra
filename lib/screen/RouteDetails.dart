import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/presenter/get_route_coordinates_presenter.dart';
import 'package:padyatra/presenter/routes_details_presenter.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/screen/NavigationScreen.dart';
import 'package:padyatra/screen/SignUp.dart';
import 'package:padyatra/screen/documents_required.dart';
import 'package:padyatra/services/DistanceCalculation.dart';
import 'package:padyatra/services/api.dart';
import 'package:padyatra/services/api_constants.dart';
import 'package:padyatra/services/currentLocation.dart';
import 'package:padyatra/weatherAPIToken/weatherAPIToken.dart';

class RouteDetailsScreen extends StatefulWidget {
  final searchedRouteName;
  final id;
  final routeID;

  const RouteDetailsScreen({
    Key key,
    this.searchedRouteName,
    this.id,
    this.routeID,
  }) : super(key: key);
  @override
  _RouteDetailsScreenState createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.searchedRouteName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor('#4e718d'),
      ),
      body: DetailsBody(
        selectedRoute: widget.searchedRouteName,
        userId: widget.id,
        routeID: widget.routeID,
      ),
    );
  }
}

class DetailsBody extends StatefulWidget {
  final selectedRoute;
  final userId;
  final routeID;
  const DetailsBody({
    Key key,
    this.selectedRoute,
    this.userId,
    this.routeID,
  }) : super(key: key);

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody>
    implements
        RouteDetailsListViewContract,
        GetRouteCoordinatesListViewContract {
  bool _isRouteBookmarked;
  var temp;
  var temperature;
  String condition;
  String weatherIcon;
  double latitude;
  double longitude;
  bool _isFetchingCurrent;
  bool _isFetchingDestination;
  bool _isImageLoading;
  bool _isWayPointsAvailable;
  GetRouteCoordinatesListPresenter _getRouteCoordinatesListPresenter;
  List<GetRouteCoordinates> _getRouteCoordinatesServerResponse;
  List<LatLng> _routeCoordinates = [];
  bool _routeCoordinatesAvailable;
  double routeTotalDistance;

  Future getDestinationWeather() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=27.700769&lon=85.300140&appid=${WeatherAPIToken().weatherToken}&units=metric');
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.condition = results['weather'][0]['icon'];
      _isFetchingDestination = false;
    });
  }

  Future<dynamic> getCurrentLocation() async {
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    // latitude = position.latitude;
    // longitude = position.longitude;
    // print(latitude);
    // print(longitude);
  }

  Future<dynamic> getCurrentWeather() async {
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    var coordinate = await CurrentLocation().getLocation();
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${WeatherAPIToken().weatherToken}&units=metric');
    var decodedData = jsonDecode(response.body);
    setState(() {
      this.weatherIcon = decodedData['weather'][0]['icon'];
      this.temperature = decodedData['main']['temp'];
      _isFetchingCurrent = false;
    });
  }

  RouteDetailsListPresenter _presenter;
  List<RouteDetails> _routeDetails;
  bool _isLoading;
  _DetailsBodyState() {
    _presenter = new RouteDetailsListPresenter(this);
    _getRouteCoordinatesListPresenter =
        new GetRouteCoordinatesListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isImageLoading = true;
    _isWayPointsAvailable = false;
    _routeCoordinatesAvailable = false;
    _presenter.loadRouteDetails(widget.selectedRoute, widget.userId);
    // _getRouteCoordinatesListPresenter
    //     .loadServerResponseCoordinates(widget.routeID);
    _isFetchingCurrent = true;
    _isFetchingDestination = true;
    this.getDestinationWeather();
    this.getCurrentWeather();
    // _isRouteBookmarked = widget.isBookmarked;
  }

  RouteDetails routeDetails;
  Widget _LoginCheckWidget() {
    showDialog(
        barrierColor: Colors.black54,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: ,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: new Text(
              "login required",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: new Text(
              "make sure that you've an account before navigating",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              new MaterialButton(
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'cancel',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              new MaterialButton(
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                child: Text(
                  'sign-up',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? new Center(
            child: new Container(),
          )
        : SingleChildScrollView(
            child: FadeAnimation1(
              1.4,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation1(
                      1.4,
                      Container(
                        // height: (displayHeight(context) -
                        //         MediaQuery.of(context).padding.top -
                        //         kToolbarHeight) *
                        //     0.28,
                        width: double.infinity,
                        child: Stack(children: <Widget>[
                          // Image(
                          //   image: AssetImage('images/AC2.png'),
                          //   fit: BoxFit.fill,
                          // ),
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            // height: 400,
                            child: _isImageLoading
                                ? new Center(
                                    child: new Container(),
                                  )
                                : Image.network(
                                    ApiConstants().imageBaseUrl +
                                        "${routeDetails.image}",
                                    fit: BoxFit.cover,
                                    height: displayHeight(context) * 0.35,
                                    width: displayWidth(context),
                                    gaplessPlayback: true,
                                  ),
                          ),
                          _isRouteBookmarked
                              ? IconButton(
                                  icon: Icon(Icons.favorite),
                                  iconSize: 35,
                                  color: _isRouteBookmarked
                                      ? Colors.amber
                                      : Colors.white,
                                  onPressed: () async {
                                    var data = {
                                      'route_id': routeDetails.routeId,
                                      'u_id': widget.userId
                                    };
                                    setBookmarkStatus(data);
                                    setState(() {
                                      _isRouteBookmarked = false;
                                      Fluttertoast.showToast(
                                          msg: "Removed from bookmark",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          // timeInSecForIosWeb: 1,
                                          backgroundColor: HexColor('#24695c'),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.favorite),
                                  iconSize: 35,
                                  color: _isRouteBookmarked
                                      ? Colors.amber
                                      : Colors.white,
                                  onPressed: () async {
                                    var data = {
                                      'route_id':
                                          routeDetails.routeId.toString(),
                                      'u_id': widget.userId.toString()
                                    };
                                    setBookmarkStatus(data);

                                    setState(() {
                                      _isRouteBookmarked = true;
                                      Fluttertoast.showToast(
                                          msg: "Added to bookmark",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          // timeInSecForIosWeb: 1,
                                          backgroundColor: HexColor('#24695c'),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  },
                                ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                child: TextButton(
                                  onPressed: () {
                                    if (widget.userId != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationScreen(
                                            userID: widget.userId,
                                            routeID: routeDetails.routeId,
                                            wayPoints: routeDetails.wayPoints,
                                            routeTotalDistance:
                                                routeTotalDistance,
                                            routeCoordinates: _routeCoordinates,
                                          ),
                                        ),
                                      );
                                    } else {
                                      _LoginCheckWidget();
                                    }
                                  },
                                  child: Text(
                                    'navigate',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    FadeAnimation1(
                      1.4,
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.fromLTRB(9, 10, 0, 0),
                        child: Text(
                          'DESCRIPTION',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Oswald'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    FadeAnimation1(
                      1.4,
                      Container(
                        padding: EdgeInsets.fromLTRB(9, 3, 9, 0),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          routeDetails.routeDescription,
                          style: TextStyle(fontFamily: 'Noto Sans'),
                          // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation1(
                      1.4,
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Container(
                          height: displayHeight(context) * 0.09,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // SizedBox(
                              //   width: 20,
                              // ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Text(
                                        'Duration',
                                        style: TextStyle(fontFamily: 'Oswald'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        "${routeDetails.duration} days",
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: displayWidth(context) * 0.17,
                              // ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Text(
                                        'Length',
                                        style: TextStyle(fontFamily: 'Oswald'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        routeTotalDistance != null
                                            ? "${routeTotalDistance.toInt().toString()} km"
                                            : "not available",
                                        style:
                                            TextStyle(fontFamily: 'Noto Sans'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: displayWidth(context) * 0.17,
                              // ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Text(
                                        'Altitude',
                                        style: TextStyle(fontFamily: 'Oswald'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        "${routeDetails.altitude} m",
                                        style:
                                            TextStyle(fontFamily: 'Noto Sans'),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation1(
                      1.4,
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              'Current Weather',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Oswald',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: Text('Current Location'),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: _isFetchingCurrent
                                            ? new Center(
                                                child:
                                                    new CircularProgressIndicator(),
                                              )
                                            : Image(
                                                image: NetworkImage(
                                                  'http://openweathermap.org/img/w/$weatherIcon.png',
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: displayWidth(context) * 0.4,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: Text('Destination'),
                                      ),
                                      Container(
                                        child: _isFetchingDestination
                                            ? new Center(
                                                child:
                                                    new CircularProgressIndicator(),
                                              )
                                            : Image(
                                                image: NetworkImage(
                                                  'http://openweathermap.org/img/w/$condition.png',
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
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
                    FadeAnimation1(
                      1.4,
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Container(
                          // height: displayHeight(context) * 0.28,
                          width: displayWidth(context) * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'paper works and permits',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, bottom: 4),
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          'Conservational and National Park Permit: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: routeDetails
                                                      .conservationalPermit ==
                                                  1
                                              ? 'required'
                                              : 'not required',
                                          style: TextStyle(
                                            color: routeDetails
                                                        .conservationalPermit ==
                                                    1
                                                ? Colors.red
                                                : Colors.teal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, bottom: 4),
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          'Trekkers Information Management System(TIMS) Card: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: routeDetails.timsPermit == 1
                                              ? 'required'
                                              : 'not required',
                                          style: TextStyle(
                                            color: routeDetails.timsPermit == 1
                                                ? Colors.red
                                                : Colors.teal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Restricted area entry Permit: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: routeDetails
                                                      .restrictedAreaPermit ==
                                                  1
                                              ? 'required'
                                              : 'not required',
                                          style: TextStyle(
                                            color: routeDetails
                                                        .restrictedAreaPermit ==
                                                    1
                                                ? Colors.red
                                                : Colors.teal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 13),
                                child: Text(
                                  'View more about required documents for permits.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Noto Sans',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DocumentRequired()));
                                    },
                                    child: Text(
                                      'view more',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    FadeAnimation1(
                      1.4,
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Container(
                          height: displayHeight(context) * 0.07,
                          width: displayWidth(context) * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 15),
                                  child: Text(
                                    'WayPoints',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: displayWidth(context) * 0.32,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              elevation: 0.0,
                                              title: Text(
                                                'WayPoints',
                                                style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                ),
                                              ),
                                              content: Container(
                                                height: displayHeight(context) *
                                                    0.15,
                                                width: 400.0,
                                                child: _isWayPointsAvailable
                                                    ? ListView.builder(
                                                        itemCount: routeDetails
                                                            .wayPoints.length,
                                                        itemBuilder:
                                                            (BuildContext ctxt,
                                                                int index) {
                                                          return new RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    '${index + 1}. ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Noto Sans',
                                                                ),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text: routeDetails
                                                                          .wayPoints[
                                                                              index]
                                                                          .wayPointName,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Noto Sans',
                                                                      ))
                                                                ]),
                                                          );
                                                        })
                                                    : Center(
                                                        child: RichText(
                                                            text: TextSpan(
                                                          text:
                                                              'Way points not available',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Oswald',
                                                          ),
                                                        )),
                                                      ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    color: Colors.green,
                                                    child: Text('close'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'view waypoints',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.04,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Future setBookmarkStatus(data) async {
    var response = await ApiCall().postData(data, 'bookmark');
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    final responseBody2 = responseBody1[0]['Response'];
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
        "An Error Occured : [Status Code : $statusCode]",
      );
    }
    return responseBody2;
  }

  @override
  void onLoadRouteDetailsError() {}

  @override
  void onLoadRouteDetailsComplete(List<RouteDetails> items) {
    setState(() {
      _routeDetails = items;
      routeDetails = _routeDetails[0];
      if (routeDetails.wayPoints.length != 0) {
        _isWayPointsAvailable = true;
      } else {
        _isWayPointsAvailable = false;
      }
      _isLoading = false;
      _isImageLoading = false;
      routeDetails.isBookmarked
          ? _isRouteBookmarked = true
          : _isRouteBookmarked = false;
      _getRouteCoordinatesListPresenter
          .loadServerResponseCoordinates(routeDetails.routeId);
    });
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
          _routeCoordinatesAvailable = true;
          routeTotalDistance =
              distanceCalculation(0, _routeCoordinates).roundToDouble();
        });
      } else {
        setState(() {
          _routeCoordinatesAvailable = false;
          _routeCoordinates = [];
        });
      }
    });
  }

  @override
  void onGetRouteCoordinatesError() {
    setState(() {
      _routeCoordinatesAvailable = false;
      _routeCoordinates = [];
    });
    try {
      throw new FetchDataException(
          "Error_Occured: Unable to fetch Route geo coordinates.");
    } catch (e) {
      print(e);
    }
  }
}
