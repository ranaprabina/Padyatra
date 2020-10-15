import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:padyatra/control_sizes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:padyatra/presenter/routes_details_presenter.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/screen/NavigationScreen.dart';

import 'package:padyatra/screen/documents_required.dart';

class RouteDetailsScreen extends StatefulWidget {
  final searchedRouteName;

  const RouteDetailsScreen({Key key, this.searchedRouteName}) : super(key: key);
  @override
  _RouteDetailsScreenState createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            // 'Annapurna Base Camp',
            widget.searchedRouteName,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Hexcolor('#4e718d'),
        ),
        body: DetailsBody(selectedRoute: widget.searchedRouteName),
      ),
    );
  }
}

class DetailsBody extends StatefulWidget {
  final selectedRoute;
  const DetailsBody({
    Key key,
    this.selectedRoute,
  }) : super(key: key);

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody>
    implements RouteDetailsListViewContract {
  var temp;
  var temperature;
  String condition;
  String weatherIcon;
  double latitude;
  double longitude;
  bool _isFetchingCurrent;
  bool _isFetchingDestination;

  Future getDestinationWeather() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=27.700769&lon=85.300140&appid=3357133e7c49f87feaa30590acaa4824&units=metric');
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
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=3357133e7c49f87feaa30590acaa4824&units=metric');
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
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    _presenter.loadRouteDetails(widget.selectedRoute);
    _isFetchingCurrent = true;
    _isFetchingDestination = true;
    this.getDestinationWeather();
    this.getCurrentWeather();
  }

  RouteDetails routeDetails;

  @override
  Widget build(BuildContext context) {
    List<String> wayItems = [
      "Nayapul",
      "NP Check Point",
      "Birethanti",
      "Lamdoni",
      "Sudame",
      "Tikhedhunga",
      "Ulleri"
    ];
    return _isLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: (displayHeight(context) -
                            MediaQuery.of(context).padding.top -
                            kToolbarHeight) *
                        0.28,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      Image(
                        image: AssetImage('images/AC2.png'),
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 15,
                        child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          NavigationScreen()));
                                },
                                child: Text(
                                  'navigate',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      )
                    ]),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                    child: Text(
                      'DESCRIPTION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(9, 3, 9, 0),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      routeDetails.routeDescription,
                      // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                            offset: Offset(0, 3), // changes position of shadow
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
                                  child: Text('Duration'),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text("${routeDetails.duration} days"),
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
                                  child: Text('Length'),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text("${routeDetails.length} km"),
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
                                  child: Text('Altitude'),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text("${routeDetails.altitude} m"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'Current Weather',
                      style: TextStyle(
                        fontSize: 18,
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
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text('Current Location'),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: _isFetchingCurrent
                                      ? new Center(
                                          child:
                                              new CircularProgressIndicator(),
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              'http://openweathermap.org/img/w/$weatherIcon.png')))
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
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                                              'http://openweathermap.org/img/w/$condition.png'))
                                  // Icon(
                                  //   Icons.wb_sunny,
                                  //   size: 60,
                                  //   color: Colors.yellow,
                                  // ),
                                  )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Container(
                      height: displayHeight(context) * 0.28,
                      width: displayWidth(context) * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4),
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      'Conservational and National Park Permit: ',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'required',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))
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
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'required',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Restricted area entry Permit: ',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'required',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 13),
                            child: Text(
                              'View more about required documents for permits.',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 10),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: RaisedButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
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
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 15),
                              child: Text(
                                'WayPoints',
                                style: TextStyle(fontSize: 16),
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
                                          title: Text('WayPoints'),
                                          content: Container(
                                            height:
                                                displayHeight(context) * 0.15,
                                            width: 400.0,
                                            child: ListView.builder(
                                                itemCount: wayItems.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return new RichText(
                                                    text: TextSpan(
                                                        text: '${index + 1}. ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '${wayItems[index]}',
                                                          )
                                                        ]),
                                                  );
                                                }),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                shape: RoundedRectangleBorder(
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
                  SizedBox(
                    height: displayHeight(context) * 0.04,
                  )
                ],
              ),
            ),
          );
  }

  @override
  void onLoadRouteDetailsError() {
    // TODO: implement onLoadRouteDetailsError
  }

  @override
  void onLoadRouteDetailsComplete(List<RouteDetails> items) {
    setState(() {
      _routeDetails = items;
      print("length of _routeDetails is");
      print(_routeDetails.length);
      routeDetails = _routeDetails[0];
      _isLoading = false;
    });
    // TODO: implement onLoadRouteDetailsComplete
  }
}
