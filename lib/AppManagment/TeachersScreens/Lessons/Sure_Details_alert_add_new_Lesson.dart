import 'package:flutter/material.dart';



class SureDetails extends StatelessWidget {
  const SureDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(" Must Enter All The Details !!"),
            ],
          )),
      title: Text(''),
    );
  }
}


