import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Quiz_page.dart';

// ignore: must_be_immutable
class SureEnterExam extends StatelessWidget {
  Map<String, dynamic> result;

  SureEnterExam({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: lRPadding * 5,
          child: Column(
            children: <Widget>[
              new Text(" are U sure ?"),
              SizedBox(
                height: lRPadding,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: lRPadding,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                            SlideRightRoute(page: GetJson(result)));
                      },
                      child: Text(
                        'Enter Exam',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: lRPadding,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      title: Text(''),
    );
  }
}
