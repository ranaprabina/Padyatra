import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/main.dart';
import 'package:padyatra/models/completed_route_model/completed_route_data.dart';
import 'package:padyatra/presenter/completed_route_presenter.dart';
import 'package:padyatra/screen/CompletedRouteDetails.dart';
import 'package:padyatra/screen/NavigationScreen.dart';
import 'package:padyatra/screen/NoConnection.dart';
import 'package:padyatra/services/api_constants.dart';

class CompletedRoutes extends StatelessWidget {
  final userId;

  const CompletedRoutes({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('Completed Routes'),
      //   elevation: 0,

      //   // leading: IconButton(
      //   //   icon: Icon(Icons.arrow_back_ios),
      //   //   onPressed: () {},
      //   // ),
      // ),
      body: RoutesCompleted(userId: userId),
    );
  }
}

class RoutesCompleted extends StatefulWidget {
  final userId;

  const RoutesCompleted({Key key, this.userId}) : super(key: key);
  @override
  _RoutesCompletedState createState() => _RoutesCompletedState();
}

class _RoutesCompletedState extends State<RoutesCompleted>
    implements CompletedRouteListViewContract {
  String userId;
  CompletedRouteListPresenter _completedRouteListPresenter;
  List<CompletedRoute> _completedRoute;
  bool _isLoading;
  bool _isRouteAvailable;
  bool _isImageLoading;
  bool hasConnection;
  var connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _RoutesCompletedState() {
    _completedRouteListPresenter = new CompletedRouteListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _isLoading = true;
    _isImageLoading = true;
    _isRouteAvailable = false;
    checkConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  checkConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            print("connected to internet");
            hasConnection = true;
            _completedRouteListPresenter.loadCompletedRoutes(userId);
          });
        } else {
          setState(() {
            print("unable to connect to internet");
            hasConnection = false;
          });
        }
      } on SocketException catch (_) {
        setState(() {
          print("unable to connect to internet");
          hasConnection = false;
        });
      }
    } else {
      setState(() {
        print("unable to connect to internet");
        hasConnection = false;
      });
    }
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
  Widget build(BuildContext context) {
    return hasConnection == false
        ? NoConnectionScreen(
            screenName: MyApp(),
            method: "pushReplacement",
          )
        : _isLoading
            ? new Container()
            : Container(
                child: Stack(
                  children: <Widget>[
                    FadeAnimation1(
                      0.3,
                      ClipPath(
                          clipper: MyClipper(),
                          child: Stack(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.only(left: 40, top: 50, right: 20),
                              height: displayHeight(context) * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      HexColor('#9EABE4'),
                                      HexColor('#9EABE4'),
                                    ]),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: FadeAnimation1(
                                      0.3,
                                      Stack(
                                        children: <Widget>[
                                          Positioned(
                                            // left: 200,
                                            child: Image.asset(
                                              "images/hike3.png",
                                              width: 150,
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 150,
                                            child: Text(
                                              "Completed Routes",
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                color: Colors.white,
                                                fontSize: 22.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    ),
                    _isRouteAvailable
                        ? Positioned(
                            child: FadeAnimation1(
                              0.5,
                              Container(
                                padding: EdgeInsets.fromLTRB(9, 180, 0, 0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _completedRoute.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final CompletedRoute completedRoute =
                                          _completedRoute[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompletedRouteDetails(
                                                        completedRoute:
                                                            completedRoute,
                                                        userId: userId,
                                                      )));
                                        },
                                        child: Card(
                                          child: Container(
                                            height:
                                                displayHeight(context) * 0.18,
                                            child: Row(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5)),
                                                  child: Container(
                                                    child: _isImageLoading
                                                        ? new Center(
                                                            child:
                                                                new CircularProgressIndicator(),
                                                          )
                                                        : Image.network(
                                                            ApiConstants()
                                                                    .imageBaseUrl +
                                                                "${completedRoute.image}",
                                                            fit: BoxFit.cover,
                                                            height: displayHeight(
                                                                    context) *
                                                                0.18,
                                                            width: displayWidth(
                                                                    context) *
                                                                0.35,
                                                            gaplessPlayback:
                                                                true,
                                                          ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              9, 9, 0, 0),
                                                      child: Container(
                                                        child: Text(
                                                          '${completedRoute.routeName}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              9, 9, 0, 0),
                                                      child: Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'Completed in : ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '${completedRoute.totalTrekkedDays} days',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              9, 9, 0, 0),
                                                      child: Icon(
                                                        Icons
                                                            .done_outline_rounded,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          )
                        : Container(
                            child: Center(
                              child: FadeAnimation1(
                                1.4,
                                RichText(
                                  // textHeightBehavior: TextHeightBehavior.fromEncoded(≈),
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'OPPS !!!!\n',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Oswald',
                                          fontSize: 45,
                                          letterSpacing: 2.0),
                                    ),
                                    TextSpan(
                                      text: _completedRoute[0].message,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'JosefinSans Regular',
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n\n😮🤦🏼\n\n',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Oswald',
                                          fontSize: 30),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
  }

  @override
  void onLoadCompletedRouteComplete(List<CompletedRoute> items) {
    setState(() {
      _completedRoute = items;
      _isLoading = false;
      _isImageLoading = false;
      CompletedRoute noCompletedRoute;
      noCompletedRoute = _completedRoute[0];

      noCompletedRoute.serverResponse == "ERROR_OCCURED"
          ? _isRouteAvailable = false
          : _isRouteAvailable = true;
    });
  }

  @override
  void onLoadCompletedRouteError() {}
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
