import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';

// ignore: must_be_immutable
class TeachersList extends StatefulWidget {
  String subject;
  bool showValue;
  String location;
  Student student;
  final auth;
  GoogleSignIn googleSignIn;

  TeachersList(this.subject, this.location, this.student, this.auth,
      this.googleSignIn, this.showValue);

  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  _TeachersListState();

  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: this.widget.student.getTeachers(
          this.widget.subject, this.widget.location, this.widget.showValue),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        List list=  snapshot.data.docs.toList();
        list.sort((a,b){if(a["Rating"]<b["Rating"]){
          return 1;
        }else{
          return 0;
        }
        });
        return new ListView(
          children: list.map((dynamic document) {
            String subjectsintext = '';


            // for (int i = 0; i < document["subjects"].length; i++) {
            //   subjectsintext += "${document["subjects"][i].toString()} - ";
            // }

            return new ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                onTap: () {
                  Teacher teacher = new Teacher(
                      document["email"],
                      "",
                      "",
                      document["FullName"],
                      document["BirthDate"],
                      document["PhoneNumber"],
                      document["Location"],
                      document["subjects"],
                      document["More"],
                      document["ProfileImg"],
                      document["Rating"],
                      document["CanGo"],
                      document.id,
                      document["Title Sentence"],
                      document["Price"],
                      document["CertifecationFileUrl"]);
                  //

                  Navigator.of(context).pushReplacement(SlideRightRoute(
                      page: TeacherHomepage(
                          teacher,
                          this.widget.student,
                          this.widget.subject,
                          this.widget.location,
                          this.widget.auth,
                          this.widget.googleSignIn,
                          this.widget.showValue)));
                },
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: document["ProfileImg"] != null
                          ? NetworkImage(document["ProfileImg"])
                          : NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                    ),
                  ),
                ),
                title: Text(
                  document["FullName"],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      rating: document["Rating"],
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 5.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                      subjectsintext != null ? subjectsintext : "subject",
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                    ))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0));
          }).toList(),
        );
      },
    );
  }
}
