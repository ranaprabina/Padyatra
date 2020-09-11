import 'package:flutter/material.dart';
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
