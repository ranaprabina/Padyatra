import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:padyatra/presenter/insert_user_interest_routeCategory_presenter.dart';
import 'package:padyatra/presenter/route_category_presenter.dart';
import 'package:padyatra/screen/HomePage.dart';

class UserSelectInterest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSelectInterestState();
}

class _UserSelectInterestState extends State<UserSelectInterest>
    implements
        RouteCategoryListViewContract,
        InsertUserInterestRouteCategoryListViewContract {
  // List<Interest> _interests;
  List<String> _filters;

  int userIdAfterSignUp;
  bool _isLoading;
  RouteCategoryListPresenter _routeCategoryListPresenter;
  List<RouteCategory> _routeCategory;

  bool _isInsertionComplete;
  bool _isCategorySelected;
  bool _test;
  InserUserInterestRouteCategoryListPresenter
      _inserUserInterestRouteCategoryListPresenter;
  List<InsertUserInterestRouteCategory> _userInteresInsertionServerResponse;
  _UserSelectInterestState() {
    _routeCategoryListPresenter = new RouteCategoryListPresenter(this);
    _inserUserInterestRouteCategoryListPresenter =
        new InserUserInterestRouteCategoryListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _routeCategoryListPresenter.loadRouteCategoryName();
    _isInsertionComplete = false;
    _isCategorySelected = false;
    _test = false;
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
  void dispose() {
    super.dispose();
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
                // Stack(
                //   children: <Widget>[
                Container(
                  child: Image.asset('images/Interest1.jpg'),
                ),
                Center(
                  // top: displayHeight(context) * 0.4,
                  // left: displayWidth(context) * 0.35,
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "WHAT ARE YOU ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "INTO?",
                            style: TextStyle(
                                // color: Hexcolor('#b0e57c'),
                                color: Colors.amber,
                                fontSize: 50,
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //   ],
                // ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                  indent: MediaQuery.of(context).size.width / 9,
                  endIndent: MediaQuery.of(context).size.width / 9,
                ),
                Wrap(
                  children: interestWidgets.toList(),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.03,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_filters.length == 0) {
                      print("categories to be inserted is empty");
                      setState(() {
                        _isInsertionComplete = false;
                      });
                    } else {
                      for (int index = 0; index < _filters.length; index++) {
                        print(_filters[index]);
                        _inserUserInterestRouteCategoryListPresenter
                            .loadServerResponse(_filters[index].toString());
                      }
                      setState(() {
                        _isInsertionComplete = true;
                        _test = true;
                      });
                    }
                    _isInsertionComplete
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text(
                                  _test
                                      ? "Insertion Successful"
                                      : "Insertion Error",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: new Text(
                                  _test
                                      ? "Selected route category has been updated!!!"
                                      : "There was an error during insertion",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                actions: [
                                  new MaterialButton(
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    height: displayHeight(context) * 0.05,
                                    minWidth: displayWidth(context) * 0.35,
                                    color: Color.fromRGBO(49, 39, 79, 1),
                                    // color: Hexcolor('#b0e57c'),
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text(
                                  _isCategorySelected
                                      ? "Insertion Unsuccessful"
                                      : "Are You Sure???",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: new Text(
                                  _isCategorySelected
                                      ? "There was an error during insertion"
                                      : "Continue without selection",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                actions: [
                                  new MaterialButton(
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    height: displayHeight(context) * 0.05,
                                    minWidth: displayWidth(context) * 0.35,
                                    color: Color.fromRGBO(49, 39, 79, 1),
                                    // color: Hexcolor('#b0e57c'),
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                  },
                  height: displayHeight(context) * 0.05,
                  minWidth: displayWidth(context) * 0.35,
                  color: Hexcolor('#b0e57c'),
                  splashColor: Colors.white,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
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
        padding: const EdgeInsets.all(8.0),
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
          selectedColor: Colors.purple,
          backgroundColor: Colors.grey[300],
          onSelected: (bool selected) {
            setState(
              () {
                if (selected) {
                  _isCategorySelected = selected;
                  print(_isCategorySelected);
                  _filters.add(interest.categoryName);
                } else {
                  _isCategorySelected = selected;
                  print(_isCategorySelected);
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

  @override
  void onInsertUserInterestRouteCategoryComplete(
      List<InsertUserInterestRouteCategory> items) {
    setState(() {
      _userInteresInsertionServerResponse = items;
      // _isInsertionComplete = true;
    });
  }

  @override
  void onInsertUserInterestRouteCategoryError() {
    throw new FetchDataException1();
  }
}

class Interest {
  const Interest(this.name);
  final String name;
}
