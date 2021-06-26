

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/UsersScreens/Sign_in_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';




// ignore: must_be_immutable
class SureLogout extends StatelessWidget {
  final auth;
  GoogleSignIn googleSignin;

  SureLogout({Key key, this.auth, this.googleSignin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(" are U sure ?"),
              SizedBox(
                height: 20,
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
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () async {
                        if (auth != null) {
                          print(auth.currentUser == null);
                          await auth.signOut();
                          print(auth.currentUser == null);

                          if (auth.currentUser == null) {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(page: SignInUser()));
                          }
                        } else {
                          try {
                            await this.googleSignin.signOut();

                            if (this.googleSignin.currentUser == null) {
                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(page: SignInUser()));
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
