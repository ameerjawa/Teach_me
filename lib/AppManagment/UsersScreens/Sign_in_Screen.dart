import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Lessons/Sure_Details_alert_add_new_Lesson.dart';
import 'package:teach_me/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/AppManagment/UsersScreens/Sign_Up_User_Screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';

import '../StudentsScreens/Student_Activity_Home_Screen.dart';
import 'checkInternet.dart';

class SignInUser extends StatefulWidget {
  SignInUser({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInUser> {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  Student student;
  Teacher teacher;
  final auth = FirebaseAuth.instance;
  DocumentSnapshot isTeacher;
  bool successFullyLogin = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount _userObj;
  bool isLoggedin = false;


  Future<bool> _login() async {
    try {
      _userObj = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await _userObj.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);


      setState(() {
        isLoggedin = true;
      });
      print("hereeeee ${_userObj.displayName}");
      return isLoggedin;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  initState(){
    super.initState();
  CheckInternet().checkConnection(context);
  }
  @override
  void dispose() {
    CheckInternet().listener.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: MainBoxDecorationStyle,
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Image.asset("assets/images/newlogologo.jpeg",
                        matchTextDirection: true, height: 200, width: 250)),
                Text(
                  'TeachMe',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kaushan',
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
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Must Type Email";
                              } else if (!value.contains("@")) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Inputfillcolor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                  new BorderRadius.circular(15.0)),
                              hintText: 'Enter your email',
                              hintStyle: InputTextStyle,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Must Type Password";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Inputfillcolor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                  new BorderRadius.circular(15.0)),
                              hintText: 'Enter your password',
                              hintStyle: InputTextStyle,
                            ),
                          ),
                        ]),
                      )),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.white60),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.blue))),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // TODO submit

                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                            new SnackBar(
                              duration: new Duration(seconds: 5),
                              content: new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  new Text(" signing in ")
                                ],
                              ),
                            ));

                        final userCredential =
                        await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        if (userCredential != null) {
                          isTeacher = await Teacher.getTeacherById(
                              userCredential.user.uid);

                          if (isTeacher.exists) {
                            teacher = new Teacher(
                                isTeacher["email"],
                                "",
                                "",
                                isTeacher["FullName"],
                                isTeacher["BirthDate"],
                                isTeacher["PhoneNumber"],
                                isTeacher["Location"],
                                isTeacher["subjects"],
                                isTeacher["More"],
                                isTeacher["ProfileImg"],
                                isTeacher["Rating"],
                                isTeacher["CanGo"],
                                isTeacher.id,
                                isTeacher["Title Sentence"],
                                isTeacher["Price"],
                                isTeacher["CertifecationFileUrl"]);
                            print(this._googleSignIn == null);
                            Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        TeacherHomepage(
                                            teacher,
                                            student,
                                            "",
                                            "",
                                            auth,
                                            this._googleSignIn,
                                            false)));
                          } else {
                            student = await Student.getStudentById(
                                userCredential.user.uid);

                            if (student == null) {
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          AccountType(auth: this.auth,
                                            googleSignIn: this._googleSignIn,
                                            userObj: this._userObj,)));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          StudentActivity(
                                            googleSignIn: _googleSignIn,
                                            auth: auth,
                                            student: student,)));
                            }
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          return showDialog(
                              context: context,
                              builder: (context) =>
                                  SureDetails(
                                      "No user found for that email !"));
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          return showDialog(
                              context: context,
                              builder: (context) =>
                                  SureDetails("wrong Email or Password !"));
                        }
                      }
                    }
                  },
                  child: const Text(
                    'sign in',
                    style:
                    TextStyle(fontSize: BtnFontSize, fontFamily: BtnFont),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "OR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: BtnFont),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(FontAwesomeIcons.google),
                    onPressed: () async {
                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                            new SnackBar(
                              duration: new Duration(seconds: 3),
                              content: new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  new Text(" signing in with Google")
                                ],
                              ),
                            ));
                        bool isLogedin = await _login();

                        if (isLogedin == true) {
                          Navigator.of(context).pushReplacement(
                              SlideRightRoute(
                                  page: AccountType(
                                    googleSignIn: _googleSignIn,
                                    userObj: _userObj,
                                  )));
                        }
                      } catch (e) {
                        print(
                            "something went wrong with googl sign in line 277 Sign_in_Screen");
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have no Account ?"),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                            SlideRightRoute(page: Sign_Up_User()));
                      },
                      child: Text(
                        'sign up',
                        style: TextStyle(
                            fontSize: BtnFontSize,
                            decoration: TextDecoration.underline,
                            fontFamily: BtnFont),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}