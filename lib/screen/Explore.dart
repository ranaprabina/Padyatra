import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/widget/NearbyRoutesCarousel.dart';

import 'package:padyatra/widget/RecentlyAddedCarousel.dart';
import 'package:padyatra/widget/SearchBar.dart';
import 'package:padyatra/widget/UserInterestCarousel.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'पदयात्रा',
          style: TextStyle(
            color: Hexcolor('#4e718d'),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ExploreBody(),
    );
  }
}

class ExploreBody extends StatelessWidget {
  const ExploreBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SearchBar(),

            UserInterestCarousel(),
            const Divider(
              color: Colors.grey,
              height: 5,
            ),
            RecentlyAdded(),
            const Divider(
              color: Colors.grey,
              height: 5,
            ),
            NearbyRoutesCarousel()

            ///add more as you wish
          ]),
        )
      ],
    );
  }
}
