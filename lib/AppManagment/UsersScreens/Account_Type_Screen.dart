import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Sign_Up_As_Student_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';

import '../TeachersScreens/Sign_Up_As_Teacher_Screen.dart';
import 'Sign_in_Screen.dart';

// ignore: must_be_immutable
class AccountType extends StatelessWidget {
  GoogleSignIn googleSignIn;
  final auth;
  GoogleSignInAccount userObj;
  Student s;

  AccountType({Key key, this.googleSignIn, this.userObj, this.auth})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () async {
                          try {
                            // **sign out**
                            if (this.googleSignIn != null) {
                              await this.googleSignIn.signOut();
                            } else if (this.auth != null) {
                              await auth.signOut();
                            }
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(page: SignInUser()));
                          } catch (e) {
                            print(
                                "something went Wrong with signing out line 76-AccountType ");
                          }
                        }),
                  ]),
              Container(
                  child: Image.asset("assets/images/newlogologo.jpeg",
                      matchTextDirection: true, height: 200, width: 250)),
              Text(
                'TeachMe',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    fontFamily: 'Kaushan',
                    color: Colors.white),
              ),
              SizedBox(height: 100),
              Center(
                child: Container(
                  width: 300,
                  child: Column(children: <Widget>[
                    Text(
                      userObj != null? "sign in as" : 'sign up as',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Teacher'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                        minimumSize: Size(100, 100),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        onPrimary: Colors.black,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontFamily: BtnFont),
                      ),
                      onPressed: () async {
                        try {
                          List<dynamic> citiesList = await Userbg.getCities();

                          if (googleSignIn == null || googleSignIn.currentUser == null) {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: SignUpTeacher(
                                        userObj: userObj,
                                        auth: this.auth,
                                        googleSignIn: this.googleSignIn,
                                        cities: citiesList)));
                          } else {
                            DocumentSnapshot isTeacher =
                            await Teacher.getTeacherById(this.userObj.id);
                            if (isTeacher.exists) {

                              Teacher teacher = new Teacher(
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

                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: TeacherHomepage(
                                          teacher,
                                          s,
                                          "",
                                          "",
                                          this.auth,
                                          this.googleSignIn,
                                          false)));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: SignUpTeacher(
                                        auth: auth,
                                          userObj: userObj,
                                          cities: citiesList)));
                            }
                          }
                        } catch (e) {
                          print(
                              "somthing went wrong with Teacher Button line 156 AccountType");
                          print(e);
                        }
                      },
                    ),

                    // ignore: deprecated_member_use
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Student'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                        onPrimary: Colors.black,
                        minimumSize: Size(100, 100),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontFamily: BtnFont),
                      ),
                      onPressed: () async {
                        try {
                          List<dynamic> citiesList = await Userbg.getCities();
                          if (userObj != null) {
                            String email = userObj.email;
                            String fullname = userObj.displayName;
                            Student student = Student(
                                email,
                                "password",
                                "verifyPassword",
                                fullname,
                                "birthDate",
                                "phoneNumber",
                                "location",
                                true);
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: StudentActivity(
                                        student, googleSignIn)));
                          } else {
                            print(this.auth);
                            Student student = Student(
                                this.auth.currentUser.email,
                                "password",
                                "verifyPassword",
                                "userObj.displayName",
                                "birthDate",
                                "phoneNumber",
                                "location",
                                true);
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: SignUpStudent(
                                      auth:auth,
                                        student: student,
                                        googleSignIn: this.googleSignIn,
                                        citiesList: citiesList)));
                          }
                        } catch (e) {
                          print(
                              "somthing went wrong with student Button line 219 AccountType");
                        }
                      },
                    ),

                    // This trailing comma makes auto-formatting nicer for build methods.
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
