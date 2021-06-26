import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Lession.dart';

import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';

import 'Add_New_Lesson_Screen.dart';
import '../Teacher_Home_Page_Screen.dart';

// ignore: must_be_immutable
class Lessons extends StatefulWidget {
  Student student;
  String location;
  String subject;
  final auth;
  GoogleSignIn googleSignIn;
  Teacher teacher;

  Lessons(this.teacher, this.auth, this.googleSignIn);

  @override
  LessonsDetails createState() => LessonsDetails(this.auth, this.googleSignIn);
}

class LessonsDetails extends State<Lessons> {
  Student student;
  String location;
  String subject;

  bool showValue = false;
  GoogleSignIn googleSignIn;

  final auth;

  LessonsDetails(this.auth, this.googleSignIn);

  Widget build(BuildContext context) {
    print(this.widget.teacher.id);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: TeacherHomepage(
                                this.widget.teacher,
                                student,
                                subject,
                                location,
                                this.auth,
                                this.googleSignIn,
                                false)));
                      }),
                  Column(children: [
                    SizedBox(
                      height: 11,
                    ),
                    Image.asset("assets/images/newlogologo.jpeg",
                        matchTextDirection: true, height: 80, width: 120),
                    Text(
                      'TeachMe',
                      style: TextStyle(
                          fontFamily: TitleFont,
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
              "Lessons",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(SlideRightRoute(
                        page: AddNewLesson(
                      teacher: this.widget.teacher,
                      googleSignIn: this.googleSignIn,
                    )));
                  },
                  child: Text("+ Add New Lesson "))
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white54),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: this
                          .widget
                          .teacher
                          .getMeetingsByTeacherId(this.widget.teacher.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return new Text('Loading...');
                        return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Lesson lesson = new Lesson(
                                document.get("Date"),
                                document.get("StudentName"),
                                document.get("TeacherId"),
                                document.get("TeacherName"),
                                document.get("Time"),
                                document.get("StuPhoneNumber"),
                                document.get("LessonSubject"));

                            return new ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(SlideRightRoute(
                                          page: AddNewLesson(
                                    teacher: this.widget.teacher,
                                    document: document,
                                    googleSignIn: this.googleSignIn,
                                  )));
                                },
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
                                  "${lesson.subject} Lesson ${lesson.date} ${lesson.time}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    SizedBox(width: .0),
                                    Text(
                                        "${lesson.studentName} : ${lesson.studentphonenumber}",
                                        style: TextStyle(color: Colors.black))
                                    //
                                  ],
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      this
                                          .widget
                                          .teacher
                                          .deleteMeetingById(document.id);
                                    }));
                          }).toList(),
                        );
                      },
                    )
                    // color: Colors.grey,

                    ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
