import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';
import 'ExamsScreens/Exams_Home_Screen.dart';
import 'Search_for_Teacher_ScreenS/Search_For_Teacher_First_Screen.dart';
import 'CoursesScreens/Courses_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Sure_Log_Out_Widget.dart';

// ignore: must_be_immutable
class StudentActivity extends StatelessWidget {
  Student student;
  GoogleSignIn googleSignIn;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;

  StudentActivity(this.student, this.googleSignIn);

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset("assets/images/newlogologo.jpeg",
                    matchTextDirection: true, height: 160, width: 250),
              ),
              Text(
                'TeachMe',
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Kaushan',
                ),
              ),
              SizedBox(height: 30),
              Text(student.email != null ? student.email : "your email",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 10),
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(20.0)),
                  //  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        duration: new Duration(seconds: 3),
                        content: new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            SizedBox(
                              width: 30,
                            ),
                            new Text(" Moving to Search-For-Teacher System ")
                          ],
                        ),
                      ));
                      List<dynamic> subjectsList = await Userbg.getSubjects();

                      List<dynamic> citiesList = await Userbg.getCities();

                      Navigator.of(context).pushReplacement(SlideRightRoute(
                          page: SearchForTeacherStudentActivity(
                              this.student,
                              this.googleSignIn,
                              this._auth,
                              subjectsList,
                              citiesList)));
                    } catch (e) {
                      print(
                          "somthing wrong with getting the subjects or the cities or the navigator line 79 Student_Activity");
                    }
                  },
                  child: Text("Search For Teacher",
                      style: TextStyle(
                          fontSize: BtnFontSize,
                          color: btnColor,
                          fontFamily: BtnFont)),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(20.0)),
                  //  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        duration: new Duration(seconds: 3),
                        content: new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            SizedBox(
                              width: 30,
                            ),
                            new Text(" Moving to Exams System ")
                          ],
                        ),
                      ));
                      List<dynamic> result = [];

                      await student
                          .getExams()
                          .then((value) => {result.add(value)});
                      Navigator.of(context).pushReplacement(ScaleRoute(
                          page:
                              ExamsHomeScreen(student, googleSignIn, result)));
                    } catch (e) {
                      print(
                          "problem in line {130-140} StudentActivityHomeScreen GoToExamsButton");
                    }
                  },
                  child: Text("Level Exams",
                      style: TextStyle(
                          fontSize: BtnFontSize,
                          color: btnColor,
                          fontFamily: BtnFont)),
                  // padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 80.0,left: 80.0),
                  // shape: new RoundedRectangleBorder(
                  //   borderRadius: new BorderRadius.circular(30.0),
                  // ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(20.0)),
                  //  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () async {
                    // ignore: deprecated_member_use
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      duration: new Duration(seconds: 3),
                      content: new Row(
                        children: <Widget>[
                          new CircularProgressIndicator(),
                          SizedBox(
                            width: 30,
                          ),
                          new Text(" Moving to Courses System ")
                        ],
                      ),
                    ));

                    try {
                      // here we store all the CoursesCategories from the firebase in resultcat variable
                      var resultCat = await this.student.getCategories();

                      Navigator.of(context).pushReplacement(SlideRightRoute(
                          page: CoursesHomePage(
                              student, googleSignIn, resultCat)));
                    } catch (e) {
                      print(
                          "somthing went wrong with getting the categories from firebase line 163 StudentActivity");
                    }
                  },
                  child: Text("Courses",
                      style: TextStyle(
                          fontSize: BtnFontSize,
                          color: btnColor,
                          fontFamily: BtnFont)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>
                      SureLogout(auth: _auth, googleSignin: googleSignIn),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
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
