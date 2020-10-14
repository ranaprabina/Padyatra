import 'package:flutter/material.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({
    Key key,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  Future<List> senddata() async {
    final response = await http.post(
        // "http://192.168.1.65/PHP%20codes/Padyatra/API's/inserUserData.php",
        "http://192.168.1.65/PHP%20codes/Padyatra/API's/userSignUp.php",
        body: {
          "first_name": first_name.text,
          "last_name": last_name.text,
          "email": email.text,
          "password": password.text,
        });
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
                          controller: first_name,
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
                          controller: last_name,
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
                          controller: email,
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
                          controller: password,
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
                          if (_formKey.currentState.validate()) {
                            senddata();
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
                              "Login",
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
                          print('skjgfk');
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
}
