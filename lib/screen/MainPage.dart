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
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: 150, bottom: 20),
            child: Container(
              child: Image.asset('images/trekking-solo.png'),
              height: height * 0.3,
            ),
          ),
          Text(
            'Get ready for your \nlifetime journey!',
            style: TextStyle(
                fontFamily: 'Playfair Display',
                color: Colors.black,
                fontSize: 24),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            'Collection of the most beautiful \ntrails in Nepal for newbies \nas well as professional travellers ',
            style: TextStyle(
                fontFamily: 'Playfair Display',
                color: Colors.black,
                fontSize: 14),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 50, right: 50),
                child: Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  color: Hexcolor('#9EABE4'),
                  padding: EdgeInsets.only(left: 40, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 50),
                child: GestureDetector(
                  onTap: () {
                    print('signup');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                    // showRouteId();
                  },
                  child: Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      color: Hexcolor('#9EABE4'),
                      padding: EdgeInsets.only(left: 40, top: 10),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Playfair Display',
                        ),
                      )),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Skip',
                style: TextStyle(
                    fontFamily: 'Playfair Display',
                    decoration: TextDecoration.underline),
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
