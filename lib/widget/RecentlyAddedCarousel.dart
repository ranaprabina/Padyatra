import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/presenter/recently_added_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';

class RecentlyAdded extends StatefulWidget {
  @override
  _RecentlyAddedState createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded>
    implements RecentlyAddedRouteListViewContract {
  final List<TrekkingRoutes> _allTrekkingRoutes =
      TrekkingRoutes.allTrekkingRoutes();
  PageController _pageController;
  int prevPage;
  RecentlyAddedRouteListPresenter _presenter;
  List<RecentlyAddedRoute> _recentRoutes;
  bool _isLoading;
  _RecentlyAddedState() {
    _presenter = new RecentlyAddedRouteListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.65)
      ..addListener(_onScroll);
    _isLoading = true;
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
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Column(
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
                              builder: (context) => RouteDetailsScreen(
                                searchedRouteName: recentRoute.routeName,
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
                                child: Image(
                                  height: displayHeight(context) * 0.25,
                                  width: displayWidth(context) * 0.52,
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/" +
                                      _allTrekkingRoutes[index].image),
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
                                      height: displayHeight(context) * 0.023,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 4.5, 0, 0),
                                        child: Text(
                                          // '${_allTrekkingRoutes[index].difficulty}',
                                          recentRoute.difficulty,
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
                                              padding: EdgeInsets.fromLTRB(
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
                                            "${recentRoute.length} km",
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
                                              padding: EdgeInsets.fromLTRB(
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
                                            "${recentRoute.duration} days",
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
            ],
          );
  }

  @override
  void onLoadRecentlyAddedRouteComplete(List<RecentlyAddedRoute> items) {
    setState(() {
      _recentRoutes = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadRecentlyAddedRouteError() {}
}
