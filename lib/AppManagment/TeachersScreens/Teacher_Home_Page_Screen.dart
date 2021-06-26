import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Edit_Profile_For_Teacher_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Lessons/Lessons_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Search_.For_Student_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';

// ignore: must_be_immutable
class TeacherHomepage extends StatefulWidget {
  Teacher teacher;
  String subject, location;
  Student student;
  final auth;
  bool showvalue;
  GoogleSignIn googleSignIn;

  TeacherHomepage(this.teacher, this.student, this.subject, this.location,
      this.auth, this.googleSignIn,this.showvalue);

  @override
  HomepageteacherState createState() => HomepageteacherState(
      teacher, student, subject, location, this.auth, this.googleSignIn);
}

class HomepageteacherState extends State<TeacherHomepage> {
  bool showvalue = false;
  Teacher teacher;
  String subject, location;
  Student student;
  final _auth;
  String subjectsintext="";

  GoogleSignIn googleSignIn;

  HomepageteacherState(this.teacher, this.student, this.subject,
      this.location, this._auth, this.googleSignIn);

  Widget build(BuildContext context) {

    for (int i=0;i<this.teacher.subjects.length;i++){

      subjectsintext+="${this.teacher.subjects[i].toString()} - ";
    }


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),


          child: SingleChildScrollView(
            child: Column(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: [
                          student != null
                              ? _showButton(context)
                              : _showLogoutButton(context),
                          Text(
                            student != null ? "Back To Results" : "",
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                        Column(children: [
                          SizedBox(
                            height: 11,
                          ),
                          Image.asset("assets/images/newlogologo.jpeg",
                              matchTextDirection: true, height: 80, width: 120),
                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontFamily: 'Kaushan',
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ]),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    this.teacher.fullName != null
                        ? this.teacher.fullName
                        : "name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),



                  Text("${subjectsintext!=null?subjectsintext:""} Teacher ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 440,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54),


                      child: Column(
                        children: [
                          RatingBarIndicator(

                            rating: this.teacher.rating != null
                                ? this.teacher.rating
                                :
                               0.0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Text(
                            'Still have no lessons',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),

                          Text(
                            "City : ${this.teacher.location != null ? this.teacher.location : ""}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),

                          Text(
                            "PhoneNumber :  ${this.teacher.phoneNumber != null ? this.teacher.phoneNumber: ""}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                              "More About Me : ${this.teacher.detailsOnExperience!=null?this.teacher.detailsOnExperience:""}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Can Go To Student ?'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: Text(
                                    this.teacher.canGo == null
                                        ? ""
                                        : this.teacher.canGo
                                            ? "Can"
                                            : "Can't",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: this.teacher.canGo == null
                                            ? ""
                                            : this.teacher.canGo
                                                ? Colors.green
                                                : Colors.red)),


                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  student != null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                                backgroundColor: Colors.white70,
                              ),
                              onPressed: () async{
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => SearchForStudent(
                                            teacher,
                                            this._auth,
                                            this.googleSignIn)));
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                                backgroundColor: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => Lessons(teacher,
                                            this._auth, this.googleSignIn)));
                              },
                              child: Text(
                                'Lessons',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                                backgroundColor: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            EditProfileForTeacher(
                                              teacher: teacher,
                                              googleSignIn: this.googleSignIn,
                                            )));
                              },
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                  // SizedBox(height: 70,),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _showLogoutButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      iconSize: 50,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => SureLogout(
          auth: this._auth,
          googleSignin: this.googleSignIn,
        ),
      ),
    );
  }

  Widget _showButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => SearchForTeacherViewTeachers(
                  s: student,
                  selectedSubject: subject,
                  selectedLocation: location
             , teacherCan: this.showvalue,)));
        });
  }
}
