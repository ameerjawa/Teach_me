import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Lession.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'Lessons_Screen.dart';
import 'Sure_Details_alert_add_new_Lesson.dart';

// ignore: must_be_immutable
class AddNewLesson extends StatefulWidget {
  final DocumentSnapshot document;
  Teacher teacher;
  final auth;
  GoogleSignIn googleSignIn;

  AddNewLesson(
      {Key key, this.teacher, this.document, this.auth, this.googleSignIn})
      : super(key: key);

  @override
  AddNewLessonState createState() =>
      AddNewLessonState(document, this.auth, this.googleSignIn);
}

class AddNewLessonState extends State<AddNewLesson> {
  String lessonSubject, stuPhoneNumber, stuName, time;
  bool canGo = false;
  final DocumentSnapshot lessonDocument;
  final dateController = TextEditingController();
  final auth;
  GoogleSignIn googleSignIn;

  AddNewLessonState(this.lessonDocument, this.auth, this.googleSignIn);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: Lessons(this.widget.teacher,
                                        this.auth, this.googleSignIn)));
                          }),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Image.asset("assets/images/newlogologo.jpeg",
                              matchTextDirection: true, height: 80, width: 120),
                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'Kaushan',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 70,
                ),
                Center(
                    child: Text(
                  this.lessonDocument != null
                      ? 'Edit Lesson'
                      : 'Add New Lesson',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Lesson information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          lessonSubject = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.lessonDocument != null
                              ? this.lessonDocument["LessonSubject"]
                              : 'Lesson subject',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          value != null
                              ? stuPhoneNumber = value
                              : stuPhoneNumber =
                                  this.lessonDocument["StuPhoneNumber"];
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.lessonDocument != null
                              ? this.lessonDocument["StuPhoneNumber"]
                              : 'Student Phone Number',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          value != null
                              ? stuName = value
                              : stuName = this.lessonDocument["StudentName"];
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.lessonDocument != null
                              ? this.lessonDocument["StudentName"]
                              : 'Student Name',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 130,
                              child: TextField(
                                readOnly: true,
                                controller: dateController,
                                textAlign: TextAlign.center,
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  dateController.text =
                                      date.toString().substring(0, 10);
                                },
                                onChanged: (value) {
                                  value != null
                                      ? dateController.text = value
                                      : dateController.text =
                                          this.lessonDocument["Date"];

                                  dateController.text = value;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white60,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  hintText: this.lessonDocument != null
                                      ? this.lessonDocument["Date"]
                                      : 'Date',
                                  hintStyle: InputTextStyle,
                                ),
                              ),
                            ),
                            Container(
                                height: 70,
                                width: 150,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    value.isEmpty
                                        ? time = this.lessonDocument["Time"]
                                        : time = value.toString();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    fillColor: Colors.white60,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0)),
                                    hintText: this.lessonDocument != null
                                        ? this.lessonDocument["Time"]
                                        : 'Time',
                                    hintStyle: InputTextStyle,
                                  ),
                                )),
                          ]),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.done,
                                size: 50,
                              ),
                              onPressed: () {
                                Map<String, dynamic> newLessonData;
                                if (this.lessonDocument != null) {
                                  newLessonData = {
                                    "Date": dateController.text.isEmpty
                                        ? this.lessonDocument["Date"]
                                        : dateController.text,
                                    "LessonSubject": lessonSubject == null
                                        ? this.lessonDocument["LessonSubject"]
                                        : lessonSubject,
                                    "StuPhoneNumber": stuPhoneNumber == null
                                        ? this.lessonDocument["StuPhoneNumber"]
                                        : stuPhoneNumber,
                                    "StudentName": stuName == null
                                        ? this.lessonDocument["StudentName"]
                                        : stuName,
                                    "TeacherId": this.widget.teacher.id,
                                    "TeacherName": this.widget.teacher.fullName,
                                    "Time": time == null
                                        ? this.lessonDocument["Time"]
                                        : time
                                  };

                                  this.widget.teacher.editMeeting(
                                      newLessonData, this.lessonDocument.id);
                                  Navigator.of(context).pushReplacement(
                                      SlideRightRoute(
                                          page: Lessons(this.widget.teacher,
                                              this.auth, this.googleSignIn)));
                                } else if (dateController.text.isEmpty ||
                                    lessonSubject.isEmpty ||
                                    stuPhoneNumber.isEmpty ||
                                    stuName.isEmpty ||
                                    time.isEmpty) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) => SureDetails());
                                } else {
                                  Lesson lesson = new Lesson(
                                      dateController.text,
                                      stuName,
                                      this.widget.teacher.id,
                                      this.widget.teacher.fullName,
                                      time,
                                      stuPhoneNumber,
                                      lessonSubject);

                                  this.widget.teacher.addMeeting(lesson);
                                  Navigator.of(context).pushReplacement(
                                      SlideRightRoute(
                                          page: Lessons(this.widget.teacher,
                                              this.auth, this.googleSignIn)));
                                }
                              })),
                    ],
                  ),
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

