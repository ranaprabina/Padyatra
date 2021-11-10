import 'package:flutter/material.dart';
import 'package:padyatra/main.dart';

class NoConnectionScreen extends StatefulWidget {
  final screenName;
  final method;

  const NoConnectionScreen({Key key, this.screenName, this.method})
      : super(key: key);

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/No_Connection.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,
            left: 30,
            child: FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                if (widget.method == "pushReplacement") {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => widget.screenName,
                    ),
                  );
                } else if (widget.method == "pop") {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) => widget.screenName,
                    ),
                  );
                }
              },
              child: Text("Retry".toUpperCase()),
            ),
          )
        ],
      ),
    );
  }
}
