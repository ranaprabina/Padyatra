import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Login.dart';
import 'package:padyatra/models/password_reset_model/password_reset_data.dart';
import 'package:padyatra/presenter/password_reset_presenter.dart';

import '../control_sizes.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen>
    implements PasswordResetListViewContract {
  final passwordController = TextEditingController();
  String password;
  final tokenController = TextEditingController();
  String token;
  bool _isPasswordReset;
  bool _hidePassword;
  PasswordReset passwordReset;
  PasswordResetListPresenter _passwordResetListPresenter;
  List<PasswordReset> _passwordResetServerResponse;

  _PasswordResetScreenState() {
    _passwordResetListPresenter = new PasswordResetListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    _isPasswordReset = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: displayHeight(context) * 0.2),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.05,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  obscureText: _hidePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "password",
                    hintText: "Enter password",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      color: Hexcolor('#24695c'),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: _hidePassword == true
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility_off,
                              ),
                              color: Hexcolor('#24695c'),
                              onPressed: () {
                                setState(() {
                                  _hidePassword = false;
                                  print("password is visible");
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
                                  print("password is hidden");
                                });
                              },
                            ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.05,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: tokenController,
                  decoration: InputDecoration(
                    labelText: "Token",
                    hintText: "Enter token from your email",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      color: Hexcolor('#24695c'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
                height: displayHeight(context) * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.transparent,
                ),
                child: TextButton(
                  onPressed: () {
                    password = passwordController.text.toString();
                    token = tokenController.text.toString();
                    if (password.isNotEmpty && token.isNotEmpty) {
                      _passwordResetListPresenter.loadServerResponse(
                          password, token);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please fill all the fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: displayHeight(context) * 0.02,
                    ),
                    child: Text(
                      "change password",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoadComplete(List<PasswordReset> items) {
    _passwordResetServerResponse = items;
    passwordReset = _passwordResetServerResponse[0];
    if (passwordReset.response.isNotEmpty) {
      passwordReset.response == "Password_Reset_Success"
          ? _isPasswordReset = true
          : _isPasswordReset = false;
      if (_isPasswordReset) {
        Fluttertoast.showToast(
          msg: "Password reset successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } else {
        passwordReset.response == "Invalid Token"
            ? Fluttertoast.showToast(
                msg: "token is not valid",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0)
            : Fluttertoast.showToast(
                msg: "server error occured",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
      }
    } else {
      _isPasswordReset = false;
      Fluttertoast.showToast(
        msg: "internal server error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void onLoadError() {
    throw FetchDataException("Internal Server Error : 500");
  }
}
