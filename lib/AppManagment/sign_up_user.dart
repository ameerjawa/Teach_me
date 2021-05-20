import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teach_me/AppManagment/sign_in.dart';
import 'package:teach_me/UserManagment/Userbg.dart';


import 'AccountType.dart';




// ignore: camel_case_types
class Sign_Up_User extends StatelessWidget {

  String email, password, verifypassword;


  Widget build(BuildContext context) {
    final _auth= FirebaseAuth.instance;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(

      body: Padding(

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


                 Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                   children:<Widget>[ IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          //     builder: (context) => sign_in()
                          // ));
                        }

                    )

             ] ),

              Icon(Icons.book, size: 150, color: Colors.white),
              SizedBox(height: 40),
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
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0)
                              ),

                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),


                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0)
                              ),
                              hintText: 'Enter new password',
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),


                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              verifypassword = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0)
                              ),
                              hintText: 'Verify your password',
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ]
                    )
                ),
              ),

              SizedBox(height: 2),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.white60,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async  {
                  Userbg user = Userbg(email, password, verifypassword, "", "", "", "");
                  await user.signUp(context);



                 },
                child: const Text(
                  'sign up',
                  style: TextStyle(fontSize: 20),
                ),
              ),

            ],
          ),
        ),

      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}