import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/ListCompletedRoutes.dart';

class CompletedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Completed Routes",
          style: TextStyle(
            color: Hexcolor('#4e718d'),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
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
      padding: EdgeInsets.fromLTRB(9, 9, 0, 0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _allCompletedRoutes.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print('Route $index clicked');
              },
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
                                "images/" + _allCompletedRoutes[index].image)),
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
                                    fontSize: 16, fontWeight: FontWeight.w500),
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
    );
  }
}
