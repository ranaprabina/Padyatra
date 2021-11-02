import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:padyatra/Animation.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/logout_model/logout_data.dart';
import 'package:padyatra/models/profile_photo_fetch_model/profile_photo_fetch_data.dart';
import 'package:padyatra/presenter/logout_presenter.dart';
import 'package:padyatra/presenter/profile_photo_fetch_presenter.dart';
import 'package:padyatra/screen/MainPage.dart';
import 'package:padyatra/screen/ProfileDialog.dart';
import 'package:padyatra/services/api.dart';
import 'package:padyatra/services/api_constants.dart';
import 'package:padyatra/services/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin
    implements ProfilePhotoListViewContract, LogoutListViewContract {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  int userId;
  String userName;
  String oldPassword;
  String password;
  String email;
  var token;
  bool _isDataLoading = true;
  File uploadimage;
  bool _hidePassword;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  ProfilePhotoListPresenter _profilePhotoListPresenter;
  ProfilePhoto profilePhoto;
  List<ProfilePhoto> _profilePhoto;
  bool _isProfilePhotoLoading;
  LogoutListPresenter _logoutListPresenter;
  Logout logout;
  List<Logout> _logout;
  bool _isLogoutSuccess;

  _MapScreenState() {
    _profilePhotoListPresenter = new ProfilePhotoListPresenter(this);
    _logoutListPresenter = new LogoutListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isProfilePhotoLoading = true;
    _isLogoutSuccess = false;
    _hidePassword = true;
    getData();
  }

  Future<void> uploadProfilePhoto(
      var profilePhotoPath, String rememberToken) async {
    var response = await ApiCall().postMultipartRequest(
        profilePhotoPath, rememberToken, 'updateUserDetails');

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "photo uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _profilePhotoListPresenter.loadServerResponse(rememberToken);
      });
    } else {
      Fluttertoast.showToast(
          msg: "unable to upload photo",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> sendUpdateData(String rememberToken, String name,
      String oldPassword, String password) async {
    var data;
    if (oldPassword.isNotEmpty && password.isNotEmpty) {
      data = {
        "name": name,
        "remember_token": rememberToken,
        "oldPassword": oldPassword,
        "password": password,
      };
    } else if (oldPassword.isNotEmpty) {
      data = {
        "name": name,
        "remember_token": rememberToken,
        "oldPassword": oldPassword,
      };
    } else {
      data = {
        "name": name,
        "remember_token": rememberToken,
      };
    }

    var response = await http
        .post('http://192.168.1.71:8000/api/updateUserDetails', body: data);
    final responseBody = jsonDecode(response.body);
    final List responseBody1 = responseBody['serverResponse'];
    var token = responseBody['token'];
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      if (responseBody1[0]['message'] == "invalid token") {
        Fluttertoast.showToast(
            msg: responseBody1[0]['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (responseBody1[0]['Response'] == "old password not matched") {
        Fluttertoast.showToast(
            msg: responseBody1[0]['Response'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (statusCode == 400) {
        Fluttertoast.showToast(
            msg: responseBody1[0]['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "update failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      oldPasswordController.clear();
      passwordController.clear();
    } else {
      HoldUserData().holdUserData(token, jsonEncode(responseBody1[0]));
      Fluttertoast.showToast(
          msg: "update success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      oldPasswordController.clear();
      passwordController.clear();
    }
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    if (token != null) {
      var userJson = localStorage.getString('user');
      var user = jsonDecode(userJson);
      userId = user['userId'];
      userName = user['name'];
      email = user['email'];
      print(userName);
      print(token);
      setState(() {
        _isDataLoading = false;
        userNameController.text = userName;
        // nameController.text = name;
        _profilePhotoListPresenter.loadServerResponse(token);
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
            child: new Container(),
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
                            FadeAnimation1(
                              0.5,
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.0, top: 20.0),
                                  child: new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      // new Icon(
                                      //   Icons.arrow_back_ios,
                                      //   color: Colors.black,
                                      //   size: 22.0,
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0.0),
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
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             FavoriteRoutes()));
                                          // logout(email);
                                          _logoutListPresenter
                                              .loadServerResponse(email);
                                        },
                                        child: Icon(
                                          Icons.logout,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            FadeAnimation1(
                              1,
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child:
                                    new Stack(fit: StackFit.loose, children: <
                                        Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: _isProfilePhotoLoading
                                              ? Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    // image: new DecorationImage(
                                                    //   image: new ExactAssetImage(
                                                    //       // TODO : here we will replace with the image file coming form network i.e database
                                                    //       'images/hike1.jpg'
                                                    //       // ApiConstants().imageBaseUrl +
                                                    //       ),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                  )) //if there is no image then show the default image
                                              : ClipRRect(
                                                  child: Image.network(
                                                    ApiConstants()
                                                            .imageBaseUrl +
                                                        "${profilePhoto.profilePhotoPath}",
                                                    width: 140,
                                                    height: 140,
                                                    fit: BoxFit.cover,
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
                                                                uploadimage,
                                                            photoPathUrl:
                                                                profilePhoto
                                                                    .profilePhotoPath),
                                                      ),
                                                    );
                                                  });
                                                },
                                              ).then((valueFromDialog) {
                                                if (valueFromDialog != null) {
                                                  setState(() {
                                                    uploadimage =
                                                        valueFromDialog;
                                                    uploadProfilePhoto(
                                                        uploadimage.path,
                                                        token);
                                                  });
                                                } else {
                                                  print(
                                                      "value from dialog is null");
                                                }
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
                              ),
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
                              FadeAnimation1(
                                1.4,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                              ),
                              FadeAnimation1(
                                1.5,
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
                              ),
                              FadeAnimation1(
                                1.5,
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
                                              // hintText: "$userName",
                                              hintStyle: TextStyle(
                                                  color: Colors.black)),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation1(
                                1.6,
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
                                            'Password',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation1(
                                1.6,
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
                                          obscureText: _hidePassword,
                                          controller: oldPasswordController,
                                          decoration: InputDecoration(
                                            hintText: "enter old password",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 8),
                                              child: _hidePassword == true
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.visibility_off,
                                                      ),
                                                      color:
                                                          HexColor('#24695c'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _hidePassword = false;
                                                        });
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.visibility,
                                                      ),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        setState(() {
                                                          _hidePassword = true;
                                                        });
                                                      },
                                                    ),
                                            ),
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation1(
                                1.6,
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
                                            'New Password',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation1(
                                1.6,
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
                                          obscureText: _hidePassword,
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            hintText: "enter new password",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 8),
                                              child: _hidePassword == true
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.visibility_off,
                                                      ),
                                                      color:
                                                          HexColor('#24695c'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _hidePassword = false;
                                                        });
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.visibility,
                                                      ),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        setState(() {
                                                          _hidePassword = true;
                                                        });
                                                      },
                                                    ),
                                            ),
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation1(
                                1.7,
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
                              ),
                              FadeAnimation1(
                                1.7,
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
                              ),
                              FadeAnimation1(
                                1.7,
                                Divider(
                                  color: Colors.grey,
                                  height: 5,
                                  indent: 25,
                                  endIndent: 15,
                                ),
                              ),
                              // FAnimation(
                              //   1.8,
                              //   Padding(
                              //     padding: EdgeInsets.only(
                              //         left: 25.0, right: 25.0, top: 25.0),
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.max,
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: <Widget>[
                              //         Expanded(
                              //           child: Container(
                              //             child: new Text(
                              //               'Phone Code',
                              //               style: TextStyle(
                              //                   fontSize: 16.0,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //           flex: 2,
                              //         ),
                              //         Expanded(
                              //           child: Container(
                              //             child: new Text(
                              //               'Mobile',
                              //               style: TextStyle(
                              //                   fontSize: 16.0,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //           flex: 2,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // FAnimation(
                              //   1.8,
                              //   Padding(
                              //     padding: EdgeInsets.only(
                              //         left: 25.0, right: 25.0, top: 2.0),
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.max,
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: <Widget>[
                              //         Flexible(
                              //           child: Padding(
                              //             padding: EdgeInsets.only(right: 10.0),
                              //             child: new TextField(
                              //               decoration: const InputDecoration(
                              //                   hintText: "Enter Phone Code"),
                              //               enabled: !_status,
                              //             ),
                              //           ),
                              //           flex: 2,
                              //         ),
                              //         Flexible(
                              //           child: new TextField(
                              //             decoration: const InputDecoration(
                              //                 hintText: "Enter Mobile"),
                              //             enabled: !_status,
                              //           ),
                              //           flex: 2,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FadeAnimation1(
              0.7,
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                    child: new RaisedButton(
                  child: new Text("Save"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      _status = true;
                      userName = userNameController.text.toString();
                      oldPassword = oldPasswordController.text.toString();
                      password = passwordController.text.toString();
                      print(userName + oldPassword + password);
                      if (userName.isNotEmpty) {
                        sendUpdateData(token, userName, oldPassword, password);
                      } else {
                        Fluttertoast.showToast(
                            msg: "username cannot be empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            // timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                )),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: FadeAnimation1(
              0.7,
              Padding(
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
        backgroundColor: HexColor('#4e718d'),
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

  @override
  void onProfilePhotoUploadComplete(List<ProfilePhoto> items) {
    setState(() {
      _profilePhoto = items;
      profilePhoto = _profilePhoto[0];
      if (profilePhoto.serverResponsMessage == "success" &&
          profilePhoto.profilePhotoPath != null) {
        setState(() {
          _isProfilePhotoLoading = false;
        });
      } else {
        setState(() {
          _isProfilePhotoLoading = true;
        });
      }
    });
  }

  @override
  void onProfilePhotoUploadError() {
    setState(() {
      _isProfilePhotoLoading = true;
    });
  }

  @override
  void onLogoutComplete(List<Logout> items) {
    setState(() {
      _logout = items;
      logout = _logout[0];
      if (logout.serverResponsMessage == "logout_success") {
        Fluttertoast.showToast(
            msg: "logged out",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        DeleteUserData().deleteUserData();
        DeleteAppOpenedStatus().deleteAppOpenedStatus();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GuestUser()));
      } else {
        Fluttertoast.showToast(
            msg: "failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  void onLogoutError() {
    setState(() {
      _isLogoutSuccess = false;
    });
  }
}
