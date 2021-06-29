import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/UsersScreens/Sign_in_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../AppManagment/Constants/constants.dart';

class Splash extends StatefulWidget {
  @override
  SplashScreen createState() => SplashScreen();
}

class SplashScreen extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacement(ScaleRoute(page: SignInUser())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MainBoxDecorationStyle,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Image.asset(
                    "assets/images/newlogologo.jpeg",
                    width: 250,
                    height: 250,
                  )),
              Text(
                'TeachMe',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kaushan',
                    fontSize: 50,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              SpinKitRipple(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
