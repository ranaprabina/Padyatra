import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';

import 'package:padyatra/models/ListCompletedRoutes.dart';

class CompletedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('Completed Routes'),
      //   elevation: 0,

      //   // leading: IconButton(
      //   //   icon: Icon(Icons.arrow_back_ios),
      //   //   onPressed: () {},
      //   // ),
      // ),
      body: RoutesCompleted(),
    );
  }
}

class RoutesCompleted extends StatefulWidget {
  @override
  _RoutesCompletedState createState() => _RoutesCompletedState();
}

class _RoutesCompletedState extends State<RoutesCompleted> {
  @override
  Widget build(BuildContext context) {
    final List<ListCompletedRoutes> _allCompletedRoutes =
        ListCompletedRoutes.allCompletedRoutes();
    return Container(
      child: Stack(
        children: <Widget>[
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
                          Hexcolor('#9EABE4'),
                          Hexcolor('#9EABE4'),
                        ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              // left: 200,
                              child: Image.asset(
                                "images/hike3.png",
                                width: 150,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 150,
                              child: Text(
                                "Completed Routes",
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
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
                  itemCount: _allCompletedRoutes.length,
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
                                    image: AssetImage("images/" +
                                        _allCompletedRoutes[index].image)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        '${_allCompletedRoutes[index].name}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(9, 9, 0, 0),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Text('Completed in:'),
                                          ),
                                          Container(
                                            child: Text(
                                                '${_allCompletedRoutes[index].daystaken}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(9, 9, 0, 0),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Text('Distance Covered:'),
                                          ),
                                          Container(
                                            child: Text(
                                                '${_allCompletedRoutes[index].length}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
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
