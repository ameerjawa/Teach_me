import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/Sign_Up_Student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';


import 'Sign_Up_Teacher.dart';
import 'sign_in.dart';

class AccountType extends StatelessWidget {

  final GoogleSignInAccount userObj;

  const AccountType({Key key, this.userObj}) : super(key: key);


  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(30.0),


          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
        child: SingleChildScrollView(
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 50,
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page:sign_in_user()
                        ));
                      }
                  ),
                   ]),
                   SizedBox(height: 20,)     ,
                  Icon(Icons.book, size: 150, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'TeachMe',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),
                  SizedBox(height: 100),
                  Center(
                    child: Container(
                      width: 300,
                      child: Column(
                          children: <Widget>[
                            Text(
                             userObj!=null?"sign in as": 'sign up as',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton(
                              child: Text('Teacher'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                minimumSize: Size(100, 100),
                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                onPrimary: Colors.white,
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontStyle: FontStyle.italic
                                ),
                              ),
                              onPressed: () {

                                Navigator.of(context).pushReplacement(SlideRightRoute(
                                    page: Sign_Up_Teacher(userObj: userObj,)

                                ));
                              },
                            ),

                            // ignore: deprecated_member_use
                            SizedBox(height: 20),
                            ElevatedButton(
                              child: Text('Student'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                onPrimary: Colors.white,
                                minimumSize: Size(100, 100),
                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontStyle: FontStyle.italic
                                ),
                              ),
                              onPressed: () {
                                Student student= Student(userObj.email, "password", "verifyPassword", userObj.displayName, "birthDate", "phoneNumber", "location",true);
                                Navigator.of(context).pushReplacement(SlideRightRoute(
                                   page: userObj==null?Sign_Up_Student(userObj: userObj,):StudentActivity(student)

                                ));
                              },
                            ),

                            // This trailing comma makes auto-formatting nicer for build methods.
                          ]
                      ),
                    ),
                  ),
                ]
            ),
          ),

      ),
    );
  }
}
