import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/screen/HomePage.dart';
import 'package:padyatra/screen/SignUp.dart';

class Login extends StatelessWidget {
  const Login({
    Key key,
  }) : super(key: key);

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
                    fontFamily: 'Playfair Display',
                    fontSize: 30,
                    color: Colors.black),
              )),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: displayWidth(context) * 0.06),
            child: Text('Login to continue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontFamily: 'Playfair Display',
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
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          Padding(
              padding: EdgeInsets.only(left: displayWidth(context) * 0.03),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.greenAccent[200],
                    fontFamily: 'Roboto'),
              )),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
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
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Playfair Display'),
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
      ))),
    );
  }
}
