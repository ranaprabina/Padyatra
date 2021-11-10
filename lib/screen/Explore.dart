import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/main.dart';
import 'package:padyatra/screen/NoConnection.dart';
import 'package:padyatra/widget/NearbyRoutesCarousel.dart';
import 'package:padyatra/widget/RecentlyAddedCarousel.dart';
import 'package:padyatra/widget/SearchBar.dart';
import 'package:padyatra/widget/SeasonName.dart';
import 'package:padyatra/widget/UserInterestCarousel.dart';

class Explore extends StatefulWidget {
  final userId;

  const Explore({Key key, this.userId}) : super(key: key);
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
    print("passed user id in explore page is \n");
    print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'पदयात्रा',
          style: TextStyle(
            color: HexColor('#4e718d'),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ExploreBody(userId: widget.userId),
    );
  }
}

class ExploreBody extends StatefulWidget {
  final userId;
  const ExploreBody({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  _ExploreBodyState createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  String userId;
  bool _isUserIdAvailable;
  bool hasConnection;
  var connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    print("user id passed is \n");
    print(userId);

    if (userId == null) {
      print("user id is null");
      _isUserIdAvailable = false;
    } else {
      print("user id is not null");
      _isUserIdAvailable = true;
    }
    checkConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  checkConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            print("connected to internet");
            hasConnection = true;
          });
        } else {
          setState(() {
            print("unable to connect to internet");
            hasConnection = false;
          });
        }
      } on SocketException catch (_) {
        setState(() {
          print("unable to connect to internet");
          hasConnection = false;
        });
      }
    } else {
      setState(() {
        print("unable to connect to internet");
        hasConnection = false;
      });
    }
  }

  updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        // case ConnectivityResult.none:
        setState(() {
          print("connection status changed to true");
          hasConnection = true;
        });
        break;
      default:
        setState(() {
          print("connection status changed to false");
          hasConnection = false;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return hasConnection == false
        ? NoConnectionScreen(
            screenName: MyApp(),
            method: "pushReplacement",
          )
        : CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SearchBar(userId: userId),
                  SeasonName(userId: userId),
                  _isUserIdAvailable
                      ? UserInterestCarousel(userId: userId)
                      : Container(),
                  // const Divider(
                  //   color: Colors.grey,
                  //   height: 5,
                  // ),
                  RecentlyAdded(userId: userId),
                  // const Divider(
                  //   color: Colors.grey,
                  //   height: 5,
                  // ),
                  NearbyRoutesCarousel(userId: userId)

                  ///add more as you wish
                ]),
              )
            ],
          );
  }
}
