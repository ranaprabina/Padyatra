import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';
import 'package:padyatra/models/select_user_interet_routes/user_interest_route_data.dart';
import 'package:padyatra/presenter/user_interest_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/api_constants.dart';

class UserInterestCarousel extends StatefulWidget {
  final userId;

  const UserInterestCarousel({Key key, this.userId}) : super(key: key);
  @override
  _UserInterestCarouselState createState() => _UserInterestCarouselState();
}

class _UserInterestCarouselState extends State<UserInterestCarousel>
    implements UserInterestRouteListViewContract {
  final List<TrekkingRoutes> _allTrekkingRoutes =
      TrekkingRoutes.allTrekkingRoutes();
  String userId;
  PageController _pageController;
  int prevPage;
  UserInterestRouteListPresenter _presenter;
  List<UserInterestRoute> _userRoutes;
  bool _isLoading;
  bool _isRouteAvailable;
  bool _isImageLoading;
  _UserInterestCarouselState() {
    _presenter = new UserInterestRouteListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.65)
      ..addListener(_onScroll);
    _isRouteAvailable = false;
    _isImageLoading = true;
    userId = widget.userId;
    if (userId == null) {
      _isLoading = false;
    } else {
      _isLoading = true;
      _presenter.loadUserRoutes(userId);
    }
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Container(
            child: _isRouteAvailable
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'You might like this',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: (displayHeight(context) -
                                MediaQuery.of(context).padding.top -
                                kToolbarHeight) *
                            0.42,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _userRoutes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final UserInterestRoute route = _userRoutes[index];
                            return GestureDetector(
                              onTap: () {
                                print("Route number $index clicked");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RouteDetailsScreen(
                                      searchedRouteName: route.routeName,
                                      id: userId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                width: displayWidth(context) * 0.52,
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Container(
                                        // height:
                                        //     displayHeight(context) * 0.25,
                                        // width:
                                        //     displayWidth(context) * 0.52,

                                        child: _isImageLoading
                                            ? new Center(
                                                child:
                                                    new CircularProgressIndicator(),
                                              )
                                            : Image.network(
                                                ApiConstants().imageBaseUrl +
                                                    "${route.image}",
                                                fit: BoxFit.cover,
                                                height: displayHeight(context) *
                                                    0.25,
                                                width: displayWidth(context) *
                                                    0.52,
                                                gaplessPlayback: true,
                                              ),
                                      ),
                                    ),
                                    Container(
                                      height: displayHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(6.0, 1.0),
                                              blurRadius: 10.0),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            width: displayWidth(context) * 0.18,
                                            height:
                                                displayHeight(context) * 0.023,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 4.5, 0, 0),
                                              child: Text(
                                                // '${_allTrekkingRoutes[index].difficulty}',
                                                route.difficulty,
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                  letterSpacing: 1.2,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: displayWidth(context) * 0.17,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Text(
                                                      'Length',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // '${_allTrekkingRoutes[index].length}',
                                                  "${route.length} km",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: displayWidth(context) * 0.12,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Text(
                                                      'Duration',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // '${_allTrekkingRoutes[index].duration}',
                                                  "${route.duration} days",
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
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Container(
                                        child: Text(
                                            // '${_allTrekkingRoutes[index].name}'
                                            route.routeName),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
  }

  @override
  void onLoadUserInterestRouteComplete(List<UserInterestRoute> items) {
    setState(() {
      _userRoutes = items;
      _isLoading = false;
      UserInterestRoute noRoute;
      print("user Interested routes are \n");
      noRoute = _userRoutes[0];
      print(noRoute.serverResponse);
      _isImageLoading = false;

      noRoute.serverResponse == "routes_not_available"
          ? _isRouteAvailable = false
          : _isRouteAvailable = true;
    });
  }

  @override
  void onLoadUserInterstRouteError() {}
}
