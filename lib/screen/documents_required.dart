import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/screen/passport.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'PAPER WORKS AND PERMIT',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Hexcolor('#4e718d'),
        ),
        body: RequiredDocument());
  }
}

class RequiredDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Text(
                  'Documents Required',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Oswald',
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Text(
                  'Authorised agencies can apply for trekking permits along with following documnets',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Noto Sans',
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Container(
                  height: displayHeight(context) * 0.41,
                  child: Passport(),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Note',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                        ),
                        children: <TextSpan>[
                      TextSpan(
                          text:
                              ': Restricted area entry permits is only obtainable through local agencies and you are not allowed to travel alone in these areas, meaning you should have at least one guide or porter when trekking.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Noto Sans',
                          ))
                    ])),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                Text(
                  'Visit Nepal Tourism Board for paper work and permits.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () async {
                        String query =
                            Uri.encodeComponent("Nepal Tourism Board");
                        String googleMapUrl =
                            "https://www.google.com/maps/search/?api=1&query=$query";
                        try {
                          if (await canLaunch(googleMapUrl)) {
                            await launch(googleMapUrl);
                          } else {
                            throw "cannot launch map";
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        'visit office',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
