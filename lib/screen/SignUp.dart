import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/Login.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';
import 'package:padyatra/presenter/user_signUp_presenter.dart';
import 'package:padyatra/screen/SelectInterest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key key,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> implements UserSignUpListViewContract {
  final nameController = TextEditingController();
  String name;
  // final lastNameController = TextEditingController();
  // String lastName;
  final emailController = TextEditingController();
  String email;
  final passwordController = TextEditingController();
  String password;
  final confirmPasswordController = TextEditingController();
  String confirmPassword;
  final _formKey = new GlobalKey<FormState>();

  String userId;
  bool _hidePassword;
  bool _isSignUpSuccess;
  bool _isEmailTaken;
  UserSignUp userSignUp;
  UserSignUpListPresenter _userSignUpListPresenter;
  List<UserSignUp> _userSignUpServerResponse;

  _SignUpState() {
    _userSignUpListPresenter = new UserSignUpListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    _isSignUpSuccess = false;
    _isEmailTaken = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "images/signup_top.png",
                  width: displayWidth(context) * 0.35,
                ),
              ),
              Positioned(
                top: displayHeight(context) * 0.1,
                left: displayWidth(context) * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome to ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oswald",
                                fontSize: 30),
                            children: [
                              TextSpan(
                                text: "पदयात्रा",
                                style: TextStyle(
                                    color: Hexcolor('#24695c'),
                                    fontFamily: "Oswald",
                                    fontSize: 30),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                      text:
                          "Let’s get you all set up so you can \naccess all our contents for free!",
                      style: TextStyle(
                          // color: Hexcolor('#24695c'),
                          color: Colors.black54,
                          fontFamily: "JosefinSans Regular",
                          fontSize: 18),
                    )),
                    // Container(
                    //   child: Text(
                    //     'Let’s get you all set up so you can \naccess all our contents for free!',
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: displayHeight(context) * 0.25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: BorderSide(
                        //       color: Colors.grey[200],
                        //     ),
                        //   ),
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "First Name",
                            hintText: "eg: John",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            prefixIcon: Icon(
                              Icons.perm_identity,
                              color: Hexcolor('#24695c'),
                              // color: Hexcolor('#e1c5c1'),
                              // color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25.0),
                      //     color: Colors.white,
                      //   ),
                      //   child: TextFormField(
                      //     controller: lastNameController,
                      //     decoration: InputDecoration(
                      //       // border: InputBorder.none,
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       labelText: "Last Name",
                      //       hintText: "eg: Doe",
                      //       hintStyle: TextStyle(color: Colors.grey),
                      //       prefixIcon: Icon(
                      //         Icons.perm_identity,
                      //         // color: Colors.teal,
                      //         color: Hexcolor('#24695c'),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "Email",
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              // color: Colors.teal,
                              color: Hexcolor('#24695c'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          obscureText: _hidePassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              // color: Colors.teal,
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
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Colors.grey),
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
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      Container(
                        height: displayHeight(context) * 0.06,
                        width: displayWidth(context),
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            name = nameController.text.toString();
                            // lastName = lastNameController.text.toString();
                            email = emailController.text.toString();
                            password = passwordController.text.toString();
                            confirmPassword =
                                confirmPasswordController.text.toString();
                            if (name.isNotEmpty &&
                                email.isNotEmpty &&
                                password.isNotEmpty &&
                                confirmPassword.isNotEmpty) {
                              password == confirmPassword
                                  ? _userSignUpListPresenter.loadServerResponse(
                                      name, email, password)
                                  : Fluttertoast.showToast(
                                      msg: "passwords are different",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      // timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
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
                            "sign up",
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
                        height: displayHeight(context) * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.5,
                                color: Colors.black,
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: displayHeight(context) * 0.01,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Login()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // color: Hexcolor('#9EABE4'),
                              color: Hexcolor('#24695c'),

                              splashColor: Colors.green,
                              child: Text(
                                "login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.w600,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
  void onUserSignUpComplete(List<UserSignUp> items) {
    setState(() {
      _userSignUpServerResponse = items;

      userSignUp = _userSignUpServerResponse[0];

      if (userSignUp.serverResponseMessage.isNotEmpty) {
        userSignUp.serverResponseMessage == "new_user_inserted_successfully"
            ? _isSignUpSuccess = true
            : _isSignUpSuccess = false;
        userSignUp.serverResponseMessage == "email_already_taken"
            ? _isEmailTaken = true
            : _isEmailTaken = false;

        if (_isSignUpSuccess) {
          _checkIfUserIsLoggedIn();
          // userId = userSignUp.userId;
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => UserSelectInterest(
          //           userId: userId,
          //         )));
          // Fluttertoast.showToast(
          //     msg: "Sign-Up Sucessful",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     // timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.green,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        }
        // else {
        //   Fluttertoast.showToast(
        //       msg: "Error occured during signup process",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       // timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }

        if (_isEmailTaken) {
          Fluttertoast.showToast(
              msg: userSignUp.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }

  @override
  void onUserSignUpError() {}

  void _checkIfUserIsLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        var userJson = localStorage.getString('user');
        var user = jsonDecode(userJson);
        userId = user['userId'].toString();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserSelectInterest(
                  userId: userId,
                )));
        Fluttertoast.showToast(
            msg: "Sign-Up Sucessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // _isUserLoggedIn = true;
      });
    }
  }
}