import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/screen/Explore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Explore(),
        // bottomNavigationBar: MyBottomNavBar(),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    //The arrow_back icon in the appbar to return to
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            print('Icon is pressed');
          },
        );
      },
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      'पदयात्रा',
      style: TextStyle(
        color: Hexcolor('#4e718d'),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
