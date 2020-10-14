import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:padyatra/screen/ProfilePage.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String u_id;
  // TextEditingController u_id = TextEditingController();
  // final _formKey = new GlobalKey<FormState>();
  // String u_id = u_idController.text;
  Future login() async {
    final response = await http.post(
        // "http://192.168.1.65/PHP%20codes/Padyatra/API's/inserUserData.php",
        "http://192.168.1.65/PHP%20codes/Padyatra/API's/login.php",
        body: {
          "email": email.text,
          "password": password.text,
          // "u_id": u_id.text,
        });
    var data = json.decode(response.body);

    print(data);
    print(data.length);
    var data1 = json.decode(data['serverResponse']);
    print(data1.length);
    // print(data['User Id']);
    // u_id = data['User Id'];
    // if (data['Respone'] == "login_success") {
    //   // await FlutterSession().set('token', email.text);
    //   Fluttertoast.showToast(
    //       msg: "Login Sucessful",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       // timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.grey,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => ProfilePage(u_id: u_id)));
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Username and password Incorrect",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       // timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.grey,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
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
            child: Form(
              // key: _formKey,
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
                    child: TextFormField(
                      controller: email,
                      // validator: EmailValidator(
                      //     errorText: 'enter a valid email address'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
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
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey)),
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
              login();
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
              print('doafgh');
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
