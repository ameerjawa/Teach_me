

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/sign_in.dart';
import 'package:teach_me/routes/pageRouter.dart';
import 'AppManagment/sign_up_user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Splash extends StatefulWidget {
  @override
  splashScreen createState() => splashScreen();
}
class splashScreen extends State<Splash>  {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()=>  Navigator.of(context).pushReplacement(ScaleRoute(
       page: sign_in_user()
    )));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue.shade200
        ),
        child: Center(

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
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
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.blue,
                ),
                child: Image.asset("assets/images/logo.jpg")
              ),
              SizedBox(height: 20),
              Text(

                'TeachMe',
                style: TextStyle(fontWeight: FontWeight.bold ,  fontSize: 50,color:Colors.white),
              ),
            SizedBox(height: 20),
              SpinKitRipple(color: Colors.black,)
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}