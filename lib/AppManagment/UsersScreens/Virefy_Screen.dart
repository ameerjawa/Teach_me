import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'package:teach_me/AppManagment/UsersScreens/Sign_Up_User_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Sign_in_Screen.dart';

class VerifyEmail extends StatefulWidget {
  final auth;

  VerifyEmail(this.auth,);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<VerifyEmail> {
  User user;

  Timer timer;

  _VerifyState();

  @override
  void initState() {
    // TODO: implement initState


    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MainBoxDecorationStyle,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              SlideRightRoute(page: Sign_Up_User()));
                        })
                  ]),
              Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                          "An Email Has been Sent to ${widget.auth.currentUser.email} please press the link in the message you get!")),
                ),
              ),

              //   SpinKitRipple(color: Colors.black,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {



    await widget.auth.currentUser.reload();
    if (widget.auth.currentUser.emailVerified) {
      timer.cancel();

      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) =>
              AccountType(
                auth: widget.auth,
              )));
    }
    //  else{
    //   user.delete();
    //   Navigator.of(context).pushReplacement(CupertinoPageRoute(
    //       builder: (context) => Sign_Up_User()));
    //
    // }
  }
}
