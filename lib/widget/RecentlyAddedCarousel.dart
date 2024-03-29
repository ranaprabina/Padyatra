import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/presenter/recently_added_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/api_constants.dart';

class RecentlyAdded extends StatefulWidget {
  final userId;
  const RecentlyAdded({Key key, this.userId}) : super(key: key);
  @override
  _RecentlyAddedState createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded>
    implements RecentlyAddedRouteListViewContract {
  PageController _pageController;
  int prevPage;
  RecentlyAddedRouteListPresenter _presenter;
  List<RecentlyAddedRoute> _recentRoutes;
  bool _isLoading;
  bool _isRouteAvailable;
  bool _isImageLoading;
  _RecentlyAddedState() {
    _presenter = new RecentlyAddedRouteListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.65)
      ..addListener(_onScroll);
    _isRouteAvailable = false;
    _isLoading = true;
    _isImageLoading = true;
    _presenter.loadRecentRoutes();
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : FadeAnimation1(
            1.4,
            Container(
              child: _isRouteAvailable
                  ? FadeAnimation1(
                      1.4,
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Recently Added',
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
                                itemCount: _recentRoutes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final RecentlyAddedRoute recentRoute =
                                      _recentRoutes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      print("Route number $index clicked");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RouteDetailsScreen(
                                            searchedRouteName:
                                                recentRoute.routeName,
                                            id: widget.userId,
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
                                            child: _isImageLoading
                                                ? new Center(
                                                    child: new Container(),
                                                  )
                                                : Image.network(
                                                    ApiConstants()
                                                            .imageBaseUrl +
                                                        "${recentRoute.image}",
                                                    fit: BoxFit.cover,
                                                    height:
                                                        displayHeight(context) *
                                                            0.25,
                                                    width:
                                                        displayWidth(context) *
                                                            0.52,
                                                    gaplessPlayback: true,
                                                  ),
                                          ),
                                          Container(
                                            height:
                                                displayHeight(context) * 0.06,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(6.0, 1.0),
                                                    blurRadius: 10.0),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  width: displayWidth(context) *
                                                      0.18,
                                                  height:
                                                      displayHeight(context) *
                                                          0.023,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      // '${_allTrekkingRoutes[index].difficulty}',
                                                      recentRoute.category,
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white,
                                                        letterSpacing: 1.2,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Duration',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Text(
                                                        "${recentRoute.duration} days",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Container(
                                              child: Text(
                                                // '${_allTrekkingRoutes[index].name}'
                                                recentRoute.routeName,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          );
  }

  @override
  void onLoadRecentlyAddedRouteComplete(List<RecentlyAddedRoute> items) {
    setState(() {
      _recentRoutes = items;
      _isLoading = false;
      RecentlyAddedRoute noRoute;
      noRoute = _recentRoutes[0];
      _isImageLoading = false;

      noRoute.serverResponse == "No_Routes_Available"
          ? _isRouteAvailable = false
          : _isRouteAvailable = true;
    });
  }

  @override
  void onLoadRecentlyAddedRouteError() {}
}
