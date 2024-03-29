import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/seasonal_route_model/seasonal_route_data.dart';
import 'package:padyatra/presenter/seasonal_route_presenter.dart';
import 'package:padyatra/screen/NoConnection.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/api_constants.dart';

class SeasonalRoutesCarousel extends StatefulWidget {
  final seasonName;
  final userId;

  const SeasonalRoutesCarousel({Key key, this.seasonName, this.userId})
      : super(key: key);
  @override
  _SeasonalRoutesCarouselState createState() => _SeasonalRoutesCarouselState();
}

class _SeasonalRoutesCarouselState extends State<SeasonalRoutesCarousel>
    implements SeasonalRouteListViewContract {
  String userId;
  String seasonName;
  SeasonalRouteListPresenter _seasonalRouteListPresenter;
  List<SeasonalRoute> _seasonalRoute;
  bool _isLoading;
  bool _isImageLoading;
  bool _isRouteAvailable;
  SeasonalRoute noRoute; //noRoute refers that there in no route available
  bool hasConnection;
  var connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  _SeasonalRoutesCarouselState() {
    _seasonalRouteListPresenter = new SeasonalRouteListPresenter(this);
  }
  @override
  void initState() {
    userId = widget.userId;
    seasonName = widget.seasonName;
    _isLoading = true;
    _isImageLoading = true;
    _isRouteAvailable = false;
    print("clicked season name is");
    print(widget.seasonName);
    print(seasonName);

    super.initState();
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
            _seasonalRouteListPresenter
                .loadSeasonalRoutes(widget.seasonName.toString());
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
            screenName: SeasonalRoutesCarousel(
              seasonName: widget.seasonName,
              userId: widget.userId,
            ),
            method: "pushReplacement",
          )
        : _isLoading
            ? new Center(
                child: new Container(),
              )
            : _isRouteAvailable
                ? FadeAnimation1(
                    0.5,
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                      child: ListView.builder(
                        itemCount: _seasonalRoute.length,
                        itemBuilder: (BuildContext context, int index) {
                          final SeasonalRoute seasonalRoute =
                              _seasonalRoute[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RouteDetailsScreen(
                                    searchedRouteName: seasonalRoute.routeName,
                                    id: userId,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: displayHeight(context) * 0.15,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)),
                                      child: Container(
                                        child: _isImageLoading
                                            ? new Center(
                                                child:
                                                    new CircularProgressIndicator(),
                                              )
                                            : Image.network(
                                                ApiConstants().imageBaseUrl +
                                                    "${seasonalRoute.image}",
                                                fit: BoxFit.cover,
                                                height: displayHeight(context) *
                                                    0.15,
                                                width:
                                                    displayWidth(context) * 0.3,
                                                gaplessPlayback: true,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Text(
                                            seasonalRoute.routeName,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: displayWidth(context) *
                                                    0.12,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'Duration',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${seasonalRoute.duration} days",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          width: displayWidth(context) * 0.35,
                                          height: displayHeight(context) * 0.03,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${seasonalRoute.category}",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                                letterSpacing: 1.2,
                                              ),
                                              textAlign: TextAlign.center,
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
                        },
                      ),
                    ),
                  )
                : FadeAnimation1(
                    0.5,
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '\n\t\t\t\tOPPS !!!!\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Oswald',
                                  fontSize: 45,
                                  letterSpacing: 2.0),
                            ),
                            TextSpan(
                              text: '\t\t\t\t\t\t\t😮🤦🏼\n\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Oswald',
                                  fontSize: 30),
                            ),
                            TextSpan(
                              text: noRoute.message,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'JosefinSans Regular',
                                fontSize: 20,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
  }

  @override
  void onLoadSeasonalRouteComplete(List<SeasonalRoute> items) {
    setState(() {
      _seasonalRoute = items;
      _isLoading = false;
      _isImageLoading = false;
      noRoute = _seasonalRoute[0];

      noRoute.serverResponse == "ERROR_OCCURED"
          ? _isRouteAvailable = false
          : _isRouteAvailable = true;
    });
  }

  @override
  void onLoadSeasonalRouteError() {
    setState(() {
      _isImageLoading = true;
      _isRouteAvailable = false;
    });
  }
}
