import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/presenter/routes_details_presenter.dart';
import 'package:padyatra/models/route_details_model/route_details_data.dart';
import 'package:padyatra/screen/NavigationScreen.dart';

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
  }

  RouteDetails routeDetails;

  @override
  Widget build(BuildContext context) {
    routeDetails = _routeDetails[0];
    return _isLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Container(
            child: Column(
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
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NavigationScreen()));
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
                              child: Icon(
                                Icons.wb_sunny,
                                size: 60,
                                color: Colors.yellow,
                              ),
                            )
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
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Icon(
                                Icons.wb_sunny,
                                size: 60,
                                color: Colors.yellow,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
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
      _isLoading = false;
    });
    // TODO: implement onLoadRouteDetailsComplete
  }
}
