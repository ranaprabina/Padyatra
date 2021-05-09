import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/screen/FavoriteRoutes.dart';
import 'package:padyatra/screen/ProfileDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final uploadimage;
  const ProfilePage({Key key, this.uploadimage}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  int userId;
  String name;
  String userName;
  String email;
  bool _isDataLoading = true;
  File uploadimage;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    uploadimage = widget.uploadimage;
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      var userJson = localStorage.getString('user');
      var user = jsonDecode(userJson);
      userId = user['userId'];
      name = user['name'];
      userName = user['name'];
      email = user['email'];
      print(userName);
      print(token);
      setState(() {
        _isDataLoading = false;
        userNameController.text = userName;
        nameController.text = name;
      });
    } else {
      setState(() {
        _isDataLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isDataLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: displayHeight(context) * 0.29,
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: new Text('PROFILE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'sans-serif-light',
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      width: displayWidth(context) * 0.5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FavoriteRoutes()));
                                      },
                                      child: Icon(
                                        Icons.logout,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(fit: StackFit.loose, children: <
                                  Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: uploadimage == null
                                            ? Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    image: new ExactAssetImage(
                                                        'images/hike1.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )) //if there is no image then show the default image
                                            : ClipRRect(
                                                child: Image.file(
                                                  uploadimage,
                                                  width: 140,
                                                  height: 140,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ))
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 90.0, right: 100.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      elevation: 0.0,
                                                      title: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Icon(Icons
                                                                      .close))),
                                                      content: Container(
                                                        height: displayHeight(
                                                                context) *
                                                            0.25,
                                                        width: 400.0,
                                                        child: MyDialog(
                                                            uploadimage:
                                                                uploadimage),
                                                      ),
                                                    );
                                                  });
                                                });
                                          },
                                          child: new CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 25.0,
                                            child: new Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25, right: 25, top: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _getEditIcon()
                                            : new Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 15.0,
                                    bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: new TextField(
                                        controller: userNameController,
                                        decoration: InputDecoration(
                                            hintText: "$userName",
                                            hintStyle:
                                                TextStyle(color: Colors.black)),
                                        enabled: !_status,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 15.0,
                                    bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: new TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            hintText: "$name",
                                            hintStyle:
                                                TextStyle(color: Colors.black)),
                                        enabled: !_status,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Email ID',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 15.0,
                                    bottom: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(child: Text('$email'))
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 5,
                                indent: 25,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Phone Code',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Mobile',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter Phone Code"),
                                          enabled: !_status,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Enter Mobile"),
                                        enabled: !_status,
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                ),
                              ),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Hexcolor('#4e718d'),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
