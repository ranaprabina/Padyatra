import 'dart:async';
import 'package:flutter/material.dart';
import 'package:padyatra/FadeAnimation.dart';
import 'package:padyatra/screen/OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;

  bool hideIcon = false;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, myPage);
  }

  void myPage() {
    _scaleController.forward();
  }

  @override
  void initState() {
    super.initState();
    startTime();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 26.0).animate(_scale2Controller)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                getSessionValues();
              }
            },
          );
  }

  getSessionValues() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnBoardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _scale2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: FadeAnimation(
                  2,
                  Container(
                    width: width / 0.8,
                    height: height / 1.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('images/trekking-two-person.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  SizedBox(height: height / 30,),
                  FadeAnimation(
                    3,
                    Text(
                      "Padyatra",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 400,
                  ),
                  FadeAnimation(
                    3.3,
                    Text(
                      "Let The Adventure Begin..!!",
                      style: TextStyle(
                          fontFamily: 'Playfair Display',
                          color: Colors.black.withOpacity(.7),
                          height: 1.4,
                          fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  FadeAnimation(
                    1,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _scale2Controller,
                            builder: (context, child) => Transform.scale(
                              scale: _scale2Animation.value,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(8, 10),
                                        blurRadius: 10.0,
                                      )
                                    ]),
                                child: hideIcon == false
                                    ? Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
