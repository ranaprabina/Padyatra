import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/screen/HomePage.dart';

class UserSelectInterest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSelectInterestState();
}

class _UserSelectInterestState extends State<UserSelectInterest> {
  List<Interest> _interests;
  List<String> _filters;

  @override
  void initState() {
    super.initState();

    _filters = <String>[];
    _interests = <Interest>[
      const Interest('Moderate'),
      const Interest('Hard'),
      const Interest('Easy'),
      const Interest('Short'),
      const Interest('Long'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Stack(children: <Widget>[
          Container(
            child: Image.asset('images/Interest1.jpg'),
          ),
          Positioned(
            top: displayHeight(context) * 0.4,
            left: displayWidth(context) * 0.35,
            child: Container(
              child: Text(
                'WHAT ARE YOU \n \t\t\t\t\t\tINTO?',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Playfair Display',
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
        Divider(),
        SizedBox(
          height: displayHeight(context) * 0.03,
        ),
        Wrap(
          children: interestWidgets.toList(),
        ),
        SizedBox(
          height: displayHeight(context) * 0.03,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Container(
            height: displayHeight(context) * 0.05,
            width: displayWidth(context) * 0.3,
            color: Hexcolor('#b0e57c'),
            padding: EdgeInsets.only(left: 30, top: 15),
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        )
      ]),
    );
  }

  Iterable<Widget> get interestWidgets sync* {
    for (Interest interest in _interests) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              interest.name[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          label: Text(interest.name),
          selected: _filters.contains(interest.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(interest.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == interest.name;
                });
              }
            });
          },
        ),
      );
    }
  }
}

class Interest {
  const Interest(this.name);
  final String name;
}
