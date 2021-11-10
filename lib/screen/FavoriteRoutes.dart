import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/main.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';
import 'package:padyatra/models/bookmarked_route_model/bookmarked_route_data.dart';
import 'package:padyatra/presenter/bookmarked_route_presenter.dart';
import 'package:padyatra/screen/NoConnection.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/api_constants.dart';

class FavoriteRoutes extends StatelessWidget {
  final userId;

  const FavoriteRoutes({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoutesFavorite(userId: userId),
    );
  }
}

class RoutesFavorite extends StatefulWidget {
  final userId;

  const RoutesFavorite({Key key, this.userId}) : super(key: key);
  @override
  _RoutesFavoriteState createState() => _RoutesFavoriteState();
}

class _RoutesFavoriteState extends State<RoutesFavorite>
    implements BookmarkedRouteListViewContract {
  String userId;
  BookmarkedRouteListPresenter _bookmarkedRouteListPresenter;
  List<BookmarkedRoute> _bookmarkedRoute;
  bool _isLoading;
  bool _isRouteAvailable;
  bool _isImageLoading;
  bool hasConnection;
  var connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  _RoutesFavoriteState() {
    _bookmarkedRouteListPresenter = new BookmarkedRouteListPresenter(this);
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
            _bookmarkedRouteListPresenter.loadBookmarkedRoutes(userId);
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
    final List<TrekkingRoutes> _allTrekkingRoutes =
        TrekkingRoutes.allTrekkingRoutes();
    return hasConnection == false
        ? NoConnectionScreen(
            screenName: MyApp(),
            method: "pushReplacement",
          )
        : _isLoading
            ? new Center(
                child: new Container(),
              )
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
                                      HexColor('#BBDBBE'),
                                      HexColor('#BBDBBE'),
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
                                            left: 210,
                                            child: Image.asset(
                                              "images/hiker.png",
                                              width: 150,
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 0,
                                            child: Container(
                                              child: Text(
                                                "Favorite Routes",
                                                style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.brown[700],
                                                  fontSize: 27.0,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                              1.4,
                              Container(
                                padding: EdgeInsets.fromLTRB(9, 180, 0, 0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _bookmarkedRoute.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final BookmarkedRoute bookmarkedRoute =
                                          _bookmarkedRoute[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RouteDetailsScreen(
                                                searchedRouteName:
                                                    bookmarkedRoute.routeName,
                                                id: userId,
                                                // isBookmarked: _isBookmarked,
                                              ),
                                            ),
                                          );
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
                                                    //  Image(
                                                    //     height: displayHeight(context) *
                                                    //         0.18,
                                                    //     width:
                                                    //         displayWidth(context) * 0.4,
                                                    //     fit: BoxFit.cover,
                                                    //     image: AssetImage("images/" +
                                                    //         _allTrekkingRoutes[index]
                                                    //             .image)),
                                                    child: _isImageLoading
                                                        ? new Center(
                                                            child:
                                                                new CircularProgressIndicator(),
                                                          )
                                                        : Image.network(
                                                            ApiConstants()
                                                                    .imageBaseUrl +
                                                                "${bookmarkedRoute.image}",
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
                                                      child: Text(
                                                        // '${_allTrekkingRoutes[index].name}',
                                                        bookmarkedRoute
                                                            .routeName,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   margin: EdgeInsets.only(
                                                    //       left: 15, top: 8),
                                                    //   child: Row(
                                                    //     children: <Widget>[
                                                    // Container(
                                                    //   width: displayWidth(
                                                    //           context) *
                                                    //       0.17,
                                                    //   child: Column(
                                                    //     children: <Widget>[
                                                    //       Container(
                                                    //         child: Padding(
                                                    //           padding:
                                                    //               EdgeInsets
                                                    //                   .fromLTRB(
                                                    //                       0,
                                                    //                       10,
                                                    //                       0,
                                                    //                       0),
                                                    //           child: Text(
                                                    //             'Length',
                                                    //             style: TextStyle(
                                                    //                 fontSize:
                                                    //                     11,
                                                    //                 fontWeight:
                                                    //                     FontWeight
                                                    //                         .w100),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //       Text(
                                                    //         // '${_allTrekkingRoutes[index].length}',
                                                    //         "${bookmarkedRoute.length} km",

                                                    //         style: TextStyle(
                                                    //           fontSize: 11,
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(
                                                    //   width: displayWidth(
                                                    //           context) *
                                                    //       0.09,
                                                    // ),
                                                    Container(
                                                      // width: displayWidth(
                                                      //         context) *
                                                      //     0.12,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              9, 9, 0, 0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            'Duration : ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Noto Sans",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: displayHeight(
                                                                    context) *
                                                                0.005,
                                                          ),
                                                          Text(
                                                            // '${_allTrekkingRoutes[index].duration}',
                                                            "${bookmarkedRoute.duration} days",

                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "Noto Sans",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: displayHeight(
                                                              context) *
                                                          0.03,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      width: displayWidth(
                                                              context) *
                                                          0.35,
                                                      height: displayHeight(
                                                              context) *
                                                          0.03,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Center(
                                                        // padding: EdgeInsets.fromLTRB(
                                                        //     0, 7, 0, 0),
                                                        child: Text(
                                                          // '${_allTrekkingRoutes[index].difficulty}',
                                                          "${bookmarkedRoute.category}",

                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Noto Sans",
                                                            letterSpacing: 1.2,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
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
                                      text: _bookmarkedRoute[0].message,
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
  void onLoadBookmarekdRouteComplete(List<BookmarkedRoute> items) {
    setState(() {
      _bookmarkedRoute = items;
      _isLoading = false;
      _isImageLoading = false;
      BookmarkedRoute noRoute;
      print('Bookmarked Routes are \n');
      noRoute = _bookmarkedRoute[0];

      noRoute.serverResponse == "ERROR_OCCURED"
          ? _isRouteAvailable = false
          : _isRouteAvailable = true;
    });
  }

  @override
  void onLoadBookmarkedRouteError() {}
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
