import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Login.dart';
import 'package:padyatra/models/get_route_coordinates_model/get_route_coordinates_data.dart';
import 'package:padyatra/presenter/get_route_coordinates_presenter.dart';

import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/SignUp.dart';

class GuestUser extends StatefulWidget {
  @override
  _GuestUserState createState() => _GuestUserState();
}

class _GuestUserState extends State<GuestUser>
    implements GetRouteCoordinatesListViewContract {
  GetRouteCoordinates getRouteCoordinates;
  GetRouteCoordinatesListPresenter _getRouteCoordinatesListPresenter;
  List<GetRouteCoordinates> _getRouteCoordinatesServerResponse;
  bool _isRouteIdLoading;

  _GuestUserState() {
    _getRouteCoordinatesListPresenter =
        new GetRouteCoordinatesListPresenter(this);
  }

  void showRouteId() {
    // routId.add(getRouteCoordinates.routeId);
    _isRouteIdLoading
        ? print("route is as not added into list")
        : print(routId);

    print(routId.length);
    for (int a = 0; a < routId.length; a++) {
      print(routId[a]);
      // print("calling api function to retrieve nearby route data");
    }

    // print(getRouteCoordinates.routeId);
  }

  @override
  void initState() {
    super.initState();
    _isRouteIdLoading = true;
    // _getRouteCoordinatesListPresenter.loadServerResponseCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            child: Image.asset('images/trekking-solo.png'),
            height: height * 0.5,
          ),
          Container(
            width: width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Get ready for your lifetime journey!',

                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.black,
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                  ),
                  //     Text(
                  //   'Get ready for your lifetime journey!',
                  //   style: TextStyle(
                  //     fontFamily: 'Playfair Display',
                  //     color: Colors.black,
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  // Text(
                  //   'Collection of the most beautiful \ntrails in Nepal for newbies \nas well as professional travellers.',
                  //   style: TextStyle(
                  //     fontFamily: 'Oswald',
                  //     color: Colors.black54,
                  //     fontSize: 18,
                  //   ),
                  // ),
                ),
                TextSpan(
                  text:
                      "\t\t\tCollection of the most beautiful trails in Nepal for newbies as well as professional travellers.",
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                )
              ]),
              // crossAxisAlignment: CrossAxisAlignment.center,
              // children: [],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 50, right: 0),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 30.0),
                  height: height * 0.05,
                  width: width * 0.3,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      print("login");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    // padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Hexcolor('#9EABE4'),
                    splashColor: Colors.green,
                    child: Text(
                      "login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 15.0,
                        // fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 50),
                child: Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Hexcolor('#9EABE4'),
                    splashColor: Colors.green,
                    child: Text(
                      "signup",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 15.0,
                        // fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
            width: width,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // color: Color.fromRGBO(49, 39, 79, 1),
              // color: Hexcolor('#cff2de'),
              color: Hexcolor('#24695c'),

              // color: Hexcolor('#efedff'),
              // hoverElevation: 10.0,
              splashColor: Colors.green,
              child: Text(
                "skip",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  double testLatitude = 28.21688560396354;
  double testLongitude = 83.98131;
  List routId = <String>[];

  @override
  void onGetRouteCoordinatesComplete(List<GetRouteCoordinates> items) {
    setState(() {
      _getRouteCoordinatesServerResponse = items;

      // print(_getRouteCoordinatesServerResponse.length);

      // for (var i = 0; i < _getRouteCoordinatesServerResponse.length; i++) {
      //   getRouteCoordinates = _getRouteCoordinatesServerResponse[i];

      //   print(getRouteCoordinates.coordinates.routeCoords[i]);

      //   if ((getRouteCoordinates.coordinates.routeCoords[0]['lat'] %
      //           testLatitude) <=
      //       1) {
      //     print("Nearby routes found");
      //     print(getRouteCoordinates.coordinates.routeCoords[0]['lat']);
      //     print(getRouteCoordinates.coordinates.routeCoords[0]['lat'] %
      //         testLatitude);

      //     print(100 % 20);
      //     routId.add(_getRouteCoordinatesServerResponse[i].routeId);
      //   } else {
      //     print("this is not a nearby route");
      //     print(testLatitude);
      //     print(getRouteCoordinates.coordinates.routeCoords[0]['lat'] %
      //         testLatitude);
      //     print(
      //         "far coordinates ${getRouteCoordinates.coordinates.routeCoords[0]['lat']}");
      //   }
      //   // }
      // }

      _isRouteIdLoading = false;
    });
  }

  @override
  void onGetRouteCoordinatesError() {
    // TODO: implement onGetRouteCoordinatesError
  }
}
