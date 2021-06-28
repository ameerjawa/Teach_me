import 'package:flutter/material.dart';



// ignore: must_be_immutable
class SureDetails extends StatelessWidget {
  String text;
   SureDetails(this.text,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(this.text),
            ],
          )),
      title: Text(''),
    );
  }
}


