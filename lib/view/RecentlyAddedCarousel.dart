import 'package:flutter/material.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';
import 'package:padyatra/models/recently_added_routes/recently_added_route_data.dart';
import 'package:padyatra/presenter/recently_added_route_presenter.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Recently Added',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300.0,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _recentRoutes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final RecentlyAddedRoute recentRoute = _recentRoutes[index];
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (BuildContext context, Widget widget) {
                        double value = 1;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page - index;
                          value =
                              (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
                        }
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: Curves.easeInOut.transform(value) * 300.0,
                            // width: Curves.easeInOut.transform(value) * 350.0,
                            child: widget,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          print("Route number $index clicked");
                        },
                        child: Container(
                          width: 210.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(6.0, 1.0),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(10.0),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Positioned(
                                bottom: 10.0,
                                child: Container(
                                  height: 70.0,
                                  width: 220.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 70,
                                          height: 20,
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
                                              recentRoute.difficulty,
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                // backgroundColor: Colors.green,
                                                color: Colors.white,
                                                letterSpacing: 1.2,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  'Length',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w100),
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
                                          width: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  'Duration',
                                                  style: TextStyle(
                                                    fontSize: 11,
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
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black26,
                                  //     offset: Offset(0.0, 2.0),
                                  //     blurRadius: 6.0,
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      // borderRadius: BorderRadius.circular(20.0),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image(
                                          height: 210,
                                          width: 210,
                                          fit: BoxFit.cover,
                                          image: AssetImage("images/" +
                                              _allTrekkingRoutes[index].image)),
                                    ),
                                    Positioned(
                                      left: 10.0,
                                      bottom: 10.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            // '${_allTrekkingRoutes[index].name}',
                                            recentRoute.routeName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
