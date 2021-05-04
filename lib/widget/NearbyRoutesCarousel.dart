import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/nearBy_route_model/nearBy_route_data.dart';
import 'package:padyatra/presenter/nearBy_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/api_constants.dart';
import 'package:padyatra/services/currentLocation.dart';

class NearbyRoutesCarousel extends StatefulWidget {
  final userId;

  const NearbyRoutesCarousel({Key key, this.userId}) : super(key: key);
  @override
  _NearbyRoutesCarouselState createState() => _NearbyRoutesCarouselState();
}

class _NearbyRoutesCarouselState extends State<NearbyRoutesCarousel>
    implements NearByRouteListViewContract {
  NearByRouteListPresenter _presenter;
  List<NearByRoute> _nearByRoutes;
  bool _isLoading;
  bool _isLocationAvailable;
  double latitude;
  double longitude;
  bool _isNearByRouteAvailable;
  bool _isImageLoading;

  _NearbyRoutesCarouselState() {
    _presenter = new NearByRouteListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isLocationAvailable = false;
    _isNearByRouteAvailable = false;
    _isImageLoading = true;
    this.location();
  }

  Future<dynamic> location() async {
    try {
      var coordinate = await CurrentLocation().getLocation();
      if (coordinate != null) {
        latitude = coordinate.latitude;
        longitude = coordinate.longitude;
        _isLocationAvailable = true;
      } else {
        _isLocationAvailable = false;
        throw new Exception();
      }
      _isLocationAvailable
          ? _presenter.loadNearByRoutes(latitude, longitude)
          : location();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            height: (displayHeight(context) -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight) *
                0.42,
            child: new Center(
              child: new SpinKitChasingDots(
                color: Colors.green,
              ),
            ),
          )
        : Container(
            child: _isNearByRouteAvailable
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Nearby Routes',
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
                      Container(
                        height: (displayHeight(context) -
                                MediaQuery.of(context).padding.top -
                                kToolbarHeight) *
                            0.42,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _nearByRoutes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final NearByRoute nearByRoute =
                                _nearByRoutes[index];
                            return GestureDetector(
                              onTap: () {
                                print("Route number $index clicked");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RouteDetailsScreen(
                                      searchedRouteName: nearByRoute.routeName,
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
                                              child:
                                                  new CircularProgressIndicator(),
                                            )
                                          : Image.network(
                                              ApiConstants().imageBaseUrl +
                                                  "/${nearByRoute.image}",
                                              fit: BoxFit.cover,
                                              height:
                                                  displayHeight(context) * 0.25,
                                              width:
                                                  displayWidth(context) * 0.52,
                                              gaplessPlayback: true,
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
                                                '${nearByRoute.category}',
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
                                                  '${nearByRoute.routeLength} km',
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
                                                  '${nearByRoute.duration} days',
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
                                        child: Text('${nearByRoute.routeName}'),
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
  void onLoadNearByRouteError() {}

  @override
  void onLoadNearByRouteComplete(List<NearByRoute> items) {
    setState(() {
      _nearByRoutes = items;
      NearByRoute _nearbyRoute;
      print("near by routes are \n");
      print(_nearByRoutes[0]);
      _nearbyRoute = _nearByRoutes[0];
      _isLoading = false;
      _isImageLoading = false;
      _nearbyRoute.response == "ERROR_OCCURED"
          ? _isNearByRouteAvailable = false
          : _isNearByRouteAvailable = true;
    });
  }
}
