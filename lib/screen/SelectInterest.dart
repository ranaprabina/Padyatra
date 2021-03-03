import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/insert_user_interest_routeCategory/insert_user_interest_routeCategory_data.dart';
import 'package:padyatra/models/routes_catefory_model/route_category_data.dart';
import 'package:padyatra/presenter/insert_user_interest_routeCategory_presenter.dart';
import 'package:padyatra/presenter/route_category_presenter.dart';
import 'package:padyatra/screen/HomePage.dart';
import 'package:toast/toast.dart';

class UserSelectInterest extends StatefulWidget {
  final userId;

  const UserSelectInterest({Key key, this.userId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserSelectInterestState();
}

class _UserSelectInterestState extends State<UserSelectInterest>
    implements
        RouteCategoryListViewContract,
        InsertUserInterestRouteCategoryListViewContract {
  // List<Interest> _interests;
  List<String> _filters;
  String userId;
  int userIdAfterSignUp;
  bool _isLoading;
  RouteCategoryListPresenter _routeCategoryListPresenter;
  List<RouteCategory> _routeCategory;

  bool _isCategorySelected;

  bool finalResponse;
  bool categoryAlreadyInDB;
  InsertUserInterestRouteCategory insertUserInterestRouteCategory;
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
    _isCategorySelected = false;
    finalResponse = false;
    // _test = false;
    userId = widget.userId;
    categoryAlreadyInDB = false;
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

  Widget _continueWithoutSelectionDialogueBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Category not selected",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: new Text(
            "continue without selection",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            new MaterialButton(
              onPressed: () {
                print(userId);
                Navigator.of(context).pop();
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              color: Color.fromRGBO(49, 39, 79, 1),
              // color: Hexcolor('#b0e57c'),
              child: Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
            Divider(),
            new MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(
                          userId: userId,
                        )));
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              color: Color.fromRGBO(49, 39, 79, 1),
              // color: Hexcolor('#b0e57c'),
              child: Text(
                'continue',
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
  }

  Widget _finalConfirmationDialogueBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Final Confirmation",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: new Text(
            "Let the Adventure Begin....",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            new MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              color: Color.fromRGBO(49, 39, 79, 1),
              // color: Hexcolor('#b0e57c'),
              child: Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
            new MaterialButton(
              onPressed: () {
                finalResponse
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              userId: userId,
                            )))
                    : Navigator.of(context).pop(
                        Toast.show(
                          categoryAlreadyInDB
                              ? insertUserInterestRouteCategory.messsage
                              : "Error occured during insertion process",
                          context,
                          backgroundColor: Colors.red[400],
                          duration: 3,
                          gravity: Toast.BOTTOM,
                        ),
                      );
              },
              height: displayHeight(context) * 0.05,
              minWidth: displayWidth(context) * 0.35,
              color: Color.fromRGBO(49, 39, 79, 1),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void insertUserInterestCategories() {
    if (!_isCategorySelected || _filters.length == 0) {
      print("categories to be inserted is empty");
      print(userId);
      print(widget.userId);
      _continueWithoutSelectionDialogueBox();
      setState(() {
        finalResponse = false;
      });
    } else {
      print("Calling for Loop now");
      for (int index = 0; index < _filters.length; index++) {
        print(_filters[index]);
        _inserUserInterestRouteCategoryListPresenter.loadServerResponse(
            _filters[index].toString(), userId);
      }
      _finalConfirmationDialogueBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    // Stack(
                    //   children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          child: Image.asset('images/Interest1.jpg'),
                        ),
                        Positioned(
                          top: 20,
                          // left: 10,
                          right: 20,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage()));
                              },
                              child: Text(
                                "skip",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Playfair Daily",
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
                        insertUserInterestCategories();
                      },
                      height: displayHeight(context) * 0.05,
                      minWidth: displayWidth(context) * 0.35,
                      color: Hexcolor('#b0e57c'),
                      splashColor: Colors.white,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
          selectedColor: Hexcolor('#93d8f8'),
          backgroundColor: Colors.grey[300],
          onSelected: (bool selected) {
            setState(
              () {
                if (selected) {
                  _isCategorySelected = selected;
                  print(_isCategorySelected);
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
      print(_userInteresInsertionServerResponse.length);
      insertUserInterestRouteCategory = _userInteresInsertionServerResponse[0];

      if (insertUserInterestRouteCategory.serverResponseMessage.isNotEmpty) {
        insertUserInterestRouteCategory.serverResponseMessage ==
                "New_Insertion_Success"
            ? finalResponse = true
            : finalResponse = false;

        insertUserInterestRouteCategory.serverResponseMessage ==
                "Category_Already_Inserted"
            ? categoryAlreadyInDB = true
            : categoryAlreadyInDB = false;
      } else {
        print("server response is empty or null");
      }
      print("Response From Server is");
      print(insertUserInterestRouteCategory.serverResponseMessage);
      print(insertUserInterestRouteCategory.userId);
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
