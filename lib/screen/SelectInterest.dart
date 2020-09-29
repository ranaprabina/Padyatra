import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:padyatra/presenter/route_category_presenter.dart';
import 'package:padyatra/screen/HomePage.dart';

class UserSelectInterest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSelectInterestState();
}

class _UserSelectInterestState extends State<UserSelectInterest>
    implements RouteCategoryListViewContract {
  // List<Interest> _interests;
  List<String> _filters;

  bool _isLoading;
  RouteCategoryListPresenter _routeCategoryListPresenter;
  List<RouteCategory> _routeCategory;
  _UserSelectInterestState() {
    _routeCategoryListPresenter = new RouteCategoryListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _routeCategoryListPresenter.loadRouteCategoryName();

    _filters = <String>[];
    // _interests = <Interest>[
    //   const Interest('Moderate'),
    //   const Interest('Hard'),
    //   const Interest('Easy'),
    //   const Interest('Short'),
    //   const Interest('Long'),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
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
              ],
            ),
          );
  }

  Iterable<Widget> get interestWidgets sync* {
    for (RouteCategory interest in _routeCategory) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              interest.categoryName[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          label: Text(interest.categoryName),
          selected: _filters.contains(interest.categoryName),
          onSelected: (bool selected) {
            setState(
              () {
                if (selected) {
                  _filters.add(interest.categoryName);
                } else {
                  _filters.removeWhere(
                    (String name) {
                      return name == interest.categoryName;
                    },
                  );
                }
              },
            );
          },
        ),
      );
    }
  }

  @override
  void onLoadRouteCategoryError() {
    throw new FetchDataException();
  }

  @override
  void onLoadSearchRouteComplete(List<RouteCategory> items) {
    // TODO: implement onLoadSearchRouteComplete
    setState(
      () {
        _routeCategory = items;
        _isLoading = false;
        print("Routes Category");
        for (int i = 0; i < _routeCategory.length; i++) {
          final RouteCategory routeCategory = _routeCategory[i];
          print(routeCategory.categoryName);
          // _interests.add(routeCategory.categoryName);
        }
      },
    );
  }
}

class Interest {
  const Interest(this.name);
  final String name;
}
