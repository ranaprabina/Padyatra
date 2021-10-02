import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/models/password_reset_token_request_model/password_reset_token_request_data.dart';
import 'package:padyatra/presenter/password_reset_token_request_presenter.dart';
import 'package:padyatra/screen/PasswordResetScreen.dart';
import '../control_sizes.dart';

class PasswordResetToken extends StatefulWidget {
  @override
  _PasswordResetTokenState createState() => _PasswordResetTokenState();
}

class _PasswordResetTokenState extends State<PasswordResetToken>
    implements PasswordResetTokenRequestListViewContract {
  final emailController = TextEditingController();
  String email;
  bool _istokenSent;
  PasswordResetTokenRequest passwordResetTokenRequest;
  PasswordResetTokenRequestListPresenter
      _passwordResetTokenRequestListPresenter;
  List<PasswordResetTokenRequest> _passwordResetTokenRequestServerResponse;
  _PasswordResetTokenState() {
    _passwordResetTokenRequestListPresenter =
        new PasswordResetTokenRequestListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _istokenSent = false;
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
                  "Request Code",
                  style: TextStyle(color: Colors.black, fontSize: 24),
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter email eg: jonh@email.com",
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
                    email = emailController.text.toString();
                    print(email);
                    email.isNotEmpty
                        ? _passwordResetTokenRequestListPresenter
                            .loadServerResponse(email)
                        : Fluttertoast.showToast(
                            msg: "Please fill email address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            // timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                  },
                  child: Text(
                    "request",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoadComplete(List<PasswordResetTokenRequest> items) {
    _passwordResetTokenRequestServerResponse = items;
    passwordResetTokenRequest = _passwordResetTokenRequestServerResponse[0];
    if (passwordResetTokenRequest.response.isNotEmpty) {
      passwordResetTokenRequest.response == "token_sent"
          ? _istokenSent = true
          : _istokenSent = false;
      if (_istokenSent) {
        Fluttertoast.showToast(
          msg: " token sent in mail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PasswordResetScreen(),
          ),
        );
      } else {
        passwordResetTokenRequest.response == "Incorrect_Email"
            ? Fluttertoast.showToast(
                msg: "email is incorrect",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0)
            : Fluttertoast.showToast(
                msg: "server error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
      }
    } else {
      _istokenSent = false;
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
