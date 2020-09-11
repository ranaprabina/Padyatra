import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';

class NearbyRoutesCarousel extends StatelessWidget {
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
                'Nearby Routes',
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
        Container(
          height: (displayHeight(context) -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight) *
              0.39,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _allTrekkingRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("Route number $index clicked");
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: displayWidth(context) * 0.52,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image(
                          height: displayHeight(context) * 0.25,
                          width: displayWidth(context) * 0.52,
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "images/" + _allTrekkingRoutes[index].image),
                        ),
                      ),
                      Container(
                        height: displayHeight(context) * 0.06,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(6.0, 1.0),
                                blurRadius: 10.0),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: displayWidth(context) * 0.18,
                              height: displayHeight(context) * 0.023,
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
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: displayWidth(context) * 0.17,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                            Container(
                              width: displayWidth(context) * 0.12,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          child: Text('${_allTrekkingRoutes[index].name}'),
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
