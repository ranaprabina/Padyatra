import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Login.dart';

import 'package:padyatra/screen/HomePage.dart';

class GuestUser extends StatelessWidget {
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
}
