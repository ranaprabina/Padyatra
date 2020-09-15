import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';

class RouteDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Annapurna Base Camp',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Hexcolor('#4e718d'),
        ),
        body: DetailsBody(),
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  const DetailsBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          height: (displayHeight(context) -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight) *
              0.28,
          width: double.infinity,
          child: Stack(children: <Widget>[
            Image(
              image: AssetImage('images/AC2.png'),
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              right: 15,
              child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                    child: Text(
                      'navigate',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ]),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
          child: Text(
            'DESCRIPTION',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(9, 3, 0, 0),
          child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Container(
            height: displayHeight(context) * 0.09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Duration'),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('12 Days'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.17,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Length'),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('115 km'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: displayWidth(context) * 0.17,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Altitude'),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('4130m'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            'Current Weather',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text('Current Location'),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(
                        Icons.wb_sunny,
                        size: 60,
                        color: Colors.yellow,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.4,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text('Destination'),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(
                        Icons.wb_sunny,
                        size: 60,
                        color: Colors.yellow,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
