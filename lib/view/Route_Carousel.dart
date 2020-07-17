import 'package:flutter/material.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';

class RouteCarousel extends StatelessWidget {
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
                'You might like this',
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
          height: 250.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _allTrekkingRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 210.0,
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 10.0,
                        child: Container(
                          height: 150.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${_allTrekkingRoutes[index].name}',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                  height: 150,
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/" +
                                      _allTrekkingRoutes[index].image)),
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
