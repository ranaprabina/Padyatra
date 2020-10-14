import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padyatra/Login.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/models/user_signUp_model/user_signUp_data.dart';
import 'package:padyatra/presenter/user_signUp_presenter.dart';
import 'package:padyatra/screen/Explore.dart';
import 'package:padyatra/screen/SelectInterest.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key key,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> implements UserSignUpListViewContract {
  final firstNameController = TextEditingController();
  String firstName;
  final lastNameController = TextEditingController();
  String lastName;
  final emailController = TextEditingController();
  String email;
  final passwordController = TextEditingController();
  String password;
  final confirmPasswordController = TextEditingController();
  String confirmPassword;
  final _formKey = new GlobalKey<FormState>();

  String userId;
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
                    Container(
                      child: Text(
                        'Welcome to पदयात्रा',
                        style: TextStyle(
                            fontSize: 30, fontFamily: 'Playfair Display'),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Let’s get you all set up so you can \naccess all our contents for free!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
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
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          // if (_formKey.currentState.validate()) {
                          //   senddata();
                          // }
                          firstName = firstNameController.text.toString();
                          lastName = lastNameController.text.toString();
                          email = emailController.text.toString();
                          password = passwordController.text.toString();
                          confirmPassword =
                              confirmPasswordController.text.toString();
                          if (firstName.isNotEmpty &&
                              lastName.isNotEmpty &&
                              email.isNotEmpty &&
                              password.isNotEmpty &&
                              confirmPassword.isNotEmpty) {
                            password == confirmPassword
                                ? _userSignUpListPresenter.loadServerResponse(
                                    firstName, lastName, email, password)
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
                        child: Container(
                          height: displayHeight(context) * 0.06,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Playfair Display'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Already have an account? Sign in",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
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
          userId = userSignUp.userId;
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
        } else {
          Fluttertoast.showToast(
              msg: "Error occured during signup process",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (_isEmailTaken) {
          Fluttertoast.showToast(
              msg: "email already taken",
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
}
