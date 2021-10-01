import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../control_sizes.dart';

class MyDialog extends StatefulWidget {
  final uploadimage;
  final photoPathUrl;
  const MyDialog({Key key, this.uploadimage, this.photoPathUrl})
      : super(key: key);
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  File uploadimage;

  @override
  void initState() {
    super.initState();
    uploadimage = widget.uploadimage;
  }

  var choosedimage;
  Future<void> chooseImage() async {
    choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: uploadimage == null
              ? Container(
                  height: 140,
                  // child: Image.asset('images/hike1.jpg'),
                  child: ClipRRect(
                    child: Image.network(widget.photoPathUrl),
                  ),
                )
              : Container(
                  child: Image.file(
                    uploadimage,
                    width: 140,
                    height: 140,
                    fit: BoxFit.fitHeight,
                  ),
                ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.03,
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      chooseImage();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("Change Picture")),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, uploadimage);
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("Sure")),
              ),
            ],
          ),
        )
      ],
    );
  }
}
