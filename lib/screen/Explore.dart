import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
