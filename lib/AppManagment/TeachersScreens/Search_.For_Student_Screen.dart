import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:teach_me/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';

import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';

// ignore: must_be_immutable
class SearchForStudent extends StatefulWidget {
  DocumentSnapshot isTeacher;
  Teacher teacher;
  String subject, location;
  Student student;
  final auth;
  GoogleSignIn googleSignin;

  SearchForStudent(this.teacher, this.auth, this.googleSignin);

  @override
  SearchForStudentState createState() =>
      SearchForStudentState();
}

class SearchForStudentState extends State<SearchForStudent> {
  bool showvalue = false;
  DocumentSnapshot isTeacher;
  String subject, location;
  Student student;

  String selectedName = "";

  SearchForStudentState();

  Widget build(BuildContext context) {

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
                          IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 50,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => TeacherHomepage(
                                            this.widget.teacher,
                                            student,
                                            subject,
                                            location,
                                            this.widget.auth,
                                            this.widget.googleSignin,false)));
                              }),
                          Text(
                            "Back To Home page",
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
                  Container(
                      height: 50,
                      width: 250,
                      child: TextField(
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (value) {
                          setState(() {
                            selectedName = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: "Type The Student Name",
                          hintStyle: TextStyle(
                              color: const Color(0xCB101010),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'NothingYouCouldDo'),
                        ),
                      )),
                  SingleChildScrollView(
                    child: Container(
                        height: 440,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white54),
                        child: StreamBuilder<QuerySnapshot>(

                          stream: selectedName!=""?this.widget.teacher.showStudentByName(selectedName):this.widget.teacher.showAllStudents(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return new Text('Loading...');
                            return new ListView(
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                return new ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  onTap: () {},
                                  leading: Container(
                                    height: 40.0,
                                    width: 1,
                                    padding: EdgeInsets.all(12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    )),
                                  ),
                                  title: Text(
                                    "${document["FullName"]} - ${document["PhoneNumber"]} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(
                                    children: <Widget>[
                                      SizedBox(width: .0),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        )
                        // color: Colors.grey,

                        ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
