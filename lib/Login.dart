import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:padyatra/models/user_login_model/user_login_data.dart';
import 'package:padyatra/presenter/user_login_presenter.dart';
import 'package:padyatra/screen/Explore.dart';
import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/SignUp.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements UserLoginListViewContract {
  final emailController = TextEditingController();
  String email;
  final passwordController = TextEditingController();
  String password;
  String userId;
  bool _hidePassword;
  bool _isLoginSucess;
  UserLogin userLogin;
  UserLoginListPresenter _userLoginListPresenter;
  List<UserLogin> _userLoginServerResponse;

  _LoginState() {
    _userLoginListPresenter = new UserLoginListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    _isLoginSucess = false;
    // _userLoginListPresenter.loadServerResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: displayHeight(context) * 0.1,
                  left: displayWidth(context) * 0.05),
              child: Text(
                'Welcome back!',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 30,
                  color: Colors.black,
                ),
              )),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: displayWidth(context) * 0.06),
            child: Text('Login to continue',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontFamily: 'JosefinSans Regular',
                )),
          ),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(left: displayWidth(context) * 0.2),
            child: Image.asset(
              'images/login.jpg',
              height: displayHeight(context) * 0.3,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
            ),
            child: Form(
              // key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter email eg: jonh@email.com",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 14),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      obscureText: _hidePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
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
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          Padding(
              padding: EdgeInsets.only(left: displayWidth(context) * 0.03),
              child: Text(
                'Forgot Password ??',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Roboto'),
              )),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          Container(
            height: displayHeight(context) * 0.06,
            width: displayWidth(context),
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                email = emailController.text.toString();
                password = passwordController.text.toString();
                if (email.isNotEmpty && password.isNotEmpty) {
                  _userLoginListPresenter.loadServerResponse(email, password);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill all the fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      // timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(49, 39, 79, 1),
              splashColor: Colors.green,
              child: Text(
                "login",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Container(
              child: Center(
                child: Text(
                  "OPS....I DON'T HAVE AN ACCOUNT YET.",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.5,
                    color: Colors.red[900],
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ))),
    );
  }

  @override
  void onUserLoginComplete(List<UserLogin> items) {
    setState(() {
      _userLoginServerResponse = items;

      userLogin = _userLoginServerResponse[0];
      if (userLogin.serverResponseMessage.isNotEmpty) {
        userLogin.serverResponseMessage == "login_success"
            ? _isLoginSucess = true
            : _isLoginSucess = false;

        print(userLogin.email);
        print(userLogin.firstName);
        print(userLogin.lastName);
        userId = userLogin.userId;

        print(userId);
        if (_isLoginSucess) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(userId: userId)));
          Fluttertoast.showToast(
              msg: "Login Sucessful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Username or password incorrect",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ProfilePage(u_id: u_id)));
      }
    });
  }

  @override
  void onUserLoginError() {}
}
