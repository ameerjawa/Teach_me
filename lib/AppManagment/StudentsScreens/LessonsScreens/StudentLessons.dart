import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Lession.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';

import '../Student_Activity_Home_Screen.dart';


class StudentLessons extends StatefulWidget {
 final Student student;
 GoogleSignIn googleSignIn;
 final auth ;
   StudentLessons({Key key,this.student,this.googleSignIn,this.auth}) : super(key: key);


  @override
  _StudentLessonsState createState() => _StudentLessonsState();
}

class _StudentLessonsState extends State<StudentLessons> {
  @override

  Widget build(BuildContext context) {

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
                            page: StudentActivity(student: widget.student,googleSignIn: this.widget.googleSignIn,auth: widget.auth,)));

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

            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white54),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: this
                          .widget
                          .student
                          .getMeetingsByStudentEmail(widget.student.email),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: new Text('Loading...'));
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
                                document.get("LessonSubject"),
                                document.get("StuEmail"));



                            return new ListTile(

                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                onTap: () {
                                  try {

                                  } catch (e) {
                                    print(
                                        "$e ");
                                  }
                                },
                                leading: Container(
                                  height: 40.0,
                                  width: 1,
                                  padding: EdgeInsets.all(12.0),
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      border: new Border(
                                        right: new BorderSide(
                                            width: 2.0, color: Colors.black),
                                      )),
                                ),
                                title: Text(
                                  "${lesson.subject.toUpperCase()} Lesson \n${lesson.date}  -  ${lesson.time}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Times New Roman"),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    SizedBox(width: .0),
                                    Text(
                                        "Teacher :${lesson.teacherName} ",
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.black))
                                    //
                                  ],
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {

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
