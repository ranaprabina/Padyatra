import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';

import 'package:padyatra/models/TrekkingRoutes.dart';

class FavoriteRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoutesFavorite(),
    );
  }
}

class RoutesFavorite extends StatefulWidget {
  @override
  _RoutesFavoriteState createState() => _RoutesFavoriteState();
}

class _RoutesFavoriteState extends State<RoutesFavorite> {
  @override
  Widget build(BuildContext context) {
    final List<TrekkingRoutes> _allTrekkingRoutes =
        TrekkingRoutes.allTrekkingRoutes();
    return Container(
        child: Stack(children: <Widget>[
      ClipPath(
          clipper: MyClipper(),
          child: Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40, top: 50, right: 20),
              height: displayHeight(context) * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Hexcolor('#BBDBBE'),
                      Hexcolor('#BBDBBE'),
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 210,
                          child: Image.asset(
                            "images/hiker.png",
                            width: 150,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 0,
                          child: Container(
                            child: Text(
                              "Favorite Routes",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.brown[700],
                                fontSize: 27.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ])),
      Positioned(
          child: Container(
        padding: EdgeInsets.fromLTRB(9, 180, 0, 0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _allTrekkingRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  child: Container(
                    height: displayHeight(context) * 0.18,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          child: Image(
                              height: displayHeight(context) * 0.18,
                              width: displayWidth(context) * 0.4,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "images/" + _allTrekkingRoutes[index].image)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 0, 0),
                              child: Text(
                                '${_allTrekkingRoutes[index].name}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, top: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: displayWidth(context) * 0.17,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Text(
                                              'Length',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${_allTrekkingRoutes[index].length}',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: displayWidth(context) * 0.09,
                                  ),
                                  Container(
                                    width: displayWidth(context) * 0.12,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Text(
                                              'Duration',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${_allTrekkingRoutes[index].duration}',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.03,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40),
                              width: displayWidth(context) * 0.35,
                              height: displayHeight(context) * 0.03,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                child: Text(
                                  '${_allTrekkingRoutes[index].difficulty}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      )),
    ]));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
