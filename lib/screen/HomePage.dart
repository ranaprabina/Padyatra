import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/screen/CompletedRoutes.dart';
import 'package:padyatra/screen/Explore.dart';
import 'package:padyatra/screen/FavoriteRoutes.dart';
import 'package:padyatra/screen/ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    Explore(),
    CompletedRoutes(),
    FavoriteRoutes(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          height: 40,
          margin: EdgeInsets.only(bottom: 20),
          child: new TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.explore),
              ),
              Tab(
                icon: Icon(Icons.done),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
            unselectedLabelColor: Hexcolor('#4e718f'),
            labelColor: Colors.green,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
