import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Login.dart';

import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/SignUp.dart';
import 'package:padyatra/services/sharedPreferences.dart';

class GuestUser extends StatefulWidget {
  @override
  _GuestUserState createState() => _GuestUserState();
}

class _GuestUserState extends State<GuestUser> {
  bool _isAppAlreadyOpened;
  @override
  void initState() {
    super.initState();
    _isAppAlreadyOpened = true;
    try {
      print("storing app opened status to true");
      HoldAppOpenedStatus().holdAppOpenedStatus(_isAppAlreadyOpened);
    } catch (e) {
      print(e);
    }
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    // padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: HexColor('#9EABE4'),
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: HexColor('#9EABE4'),
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // color: Color.fromRGBO(49, 39, 79, 1),
              // color: Hexcolor('#cff2de'),
              color: HexColor('#24695c'),

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
}
