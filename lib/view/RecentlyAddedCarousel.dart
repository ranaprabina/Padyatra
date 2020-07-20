import 'package:flutter/material.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';

class RecentlyAdded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<TrekkingRoutes> _allTrekkingRoutes =
        TrekkingRoutes.allTrekkingRoutes();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recently Added',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _allTrekkingRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("Route number $index clicked");
                },
                child: Container(
                  width: 210.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(6.0, 1.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 10.0,
                        child: Container(
                          height: 70.0,
                          width: 220.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 4.5, 0, 0),
                                    child: Text(
                                      '${_allTrekkingRoutes[index].difficulty}',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        // backgroundColor: Colors.green,
                                        color: Colors.white,
                                        letterSpacing: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Length',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w100),
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
                                Container(
                                  width: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Duration',
                                          style: TextStyle(
                                            fontSize: 11,
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
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black26,
                          //     offset: Offset(0.0, 2.0),
                          //     blurRadius: 6.0,
                          //   ),
                          // ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              // borderRadius: BorderRadius.circular(20.0),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image(
                                  height: 210,
                                  width: 210,
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/" +
                                      _allTrekkingRoutes[index].image)),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '${_allTrekkingRoutes[index].name}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
