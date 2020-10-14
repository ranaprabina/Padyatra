import 'package:flutter/material.dart';

class Passport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> litems = [
      "Online application form(trekers) Link to Trekking Permit Application",
      "Copy of passport",
      "Copy of valid Visa sufficient to cover trekking days",
      "Name lists of trekkers",
      "Program Schedule of trekking",
      "Guarantee letter of Agency",
      "Agreement with Agency",
      "Tax clearance Certicicate of Trekking Agency",
      "Documents relating to insurance of the trekkers(foreign nationals) and Nepalase staff accompanying the trekkers",
      "Registration Certificate of Permanent Account Number",
      "License issued by The Ministry of Tourism, Culture and Civil Aviation to operate trekking bussiness",
      "Voucher of Bank payment(fees) for permits",
      "License issued by Nepal Rastra Bank allowing exchanging of foreign currencies"
    ];
    return ListView.builder(
        itemCount: litems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new RichText(
            text: TextSpan(
                text: '${index + 1}. ',
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: '${litems[index]}',
                  )
                ]),
          );
        });
  }
}
