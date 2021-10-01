import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/UsersScreens/Sign_in_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/UsersScreens/Virefy_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: camel_case_types, must_be_immutable
class Sign_Up_User extends StatelessWidget {
  String email="", password="", verifypassword="";
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              SlideRightRoute(page: SignInUser()));
                        })
                  ]),
              Container(
                  child: SvgPicture.asset("assets/images/bookimage.svg",
                      allowDrawingOutsideViewBox: true,
                      matchTextDirection: true,
                      color: Colors.blue.shade900,
                      height: 200,
                      width: 400)),
              Text(
                'TeachMe',
                style: TextStyle(
                    fontFamily: 'Kaushan',
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            this.email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Must Type Email";
                            }else if (!value.contains("@")){
                              return "Envalid email!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            hintText: 'Enter your email',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            this.password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Must Type New Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            hintText: 'Enter new password',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            verifypassword = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null)
                              return "ReType Your Password";
                            if (value != password) return 'Passwords not Match';
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            hintText: 'Verify your password',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                      ]),
                    )),
              ),
              SizedBox(height: 2),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white60),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.blue))),
                onPressed: () async {
                  try {
                    if (_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        duration: new Duration(seconds: 3),
                        content: new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            SizedBox(
                              width: 30,
                            ),
                            new Text(" Moving to verify email ")
                          ],
                        ),
                      ));


                      auth
                          .createUserWithEmailAndPassword(
                          email: this.email, password: this.password)
                          .then((value) {
                        auth.signInWithCredential(value.credential);
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    VerifyEmail(auth,)));
                      });






                    }
                  } catch (e) {
                    print(
                        "something went wrong with signing up line 168 signupScreen"+e.toString());
                  }
                },
                child: const Text(
                  'sign up',
                  style: TextStyle(fontSize: BtnFontSize, fontFamily: BtnFont),
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
