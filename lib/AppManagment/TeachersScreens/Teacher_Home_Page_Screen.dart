import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Sure_Log_Out_Widget.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Edit_Profile_For_Teacher_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Lessons/Lessons_Screen.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Search_.For_Student_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';

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
     );
}

class HomepageteacherState extends State<TeacherHomepage> {
  bool showvalue = false;
  String subjectsintext="";


  HomepageteacherState();

  Widget build(BuildContext context) {

    subjectsintext="";
    for (int i=0;i<this.widget.teacher.subjects.length;i++){

      subjectsintext+="${this.widget.teacher.subjects[i].toString()} - ";
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
                          widget.student != null
                              ? _showButton(context)
                              : _showLogoutButton(context),
                          Text(
                            widget.student != null ? "Back To Results" : "",
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


                  Padding(
                    padding: EdgeInsets.only(left: 40.0,right:40.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: 100,

                          child: GestureDetector(

                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:NetworkImage(this.widget.teacher.proImg) ,
                            ),
                          ),
                        ),
                        SizedBox(width: 40,),
                        Text(
                          this.widget.teacher.fullName != null
                              ? this.widget.teacher.fullName
                              : "name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,fontFamily: BtnFont),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),



                  Padding(

                    padding: const EdgeInsets.only(left:20.0,right:20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${subjectsintext!=null?subjectsintext:""} ",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        Text("Teacher ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ],
                    ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("Rating",style: TextStyle(
                              fontFamily: 'Times New Roman',fontSize: InputFontSize
                            ),),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8.0,top: 8.0),
                            child: RatingBarIndicator(

                              rating: this.widget.teacher.rating != null
                                  ? this.widget.teacher.rating
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
                          ),
                          Center(child: Text(
                            this.widget.teacher.titleSentence
                          ),),
                          SizedBox(
                            height: 20,
                          ),



                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "City : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Times New Roman'),
                                    ),
                                    Text(
                                      " ${this.widget.teacher.location != null ? this.widget.teacher.location : ""}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Times New Roman'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Phone :  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Times New Roman'),
                                    ),
                                    Text(
                                      "${this.widget.teacher.phoneNumber != null ? this.widget.teacher.phoneNumber: ""}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Times New Roman'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Text(
                                    "More :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,fontFamily: 'Times New Roman'
                                    ),

                                  ),
                                ),
                                SizedBox(height: 10,),
                                Center(
                                  child: Container(
                                    height: 140,
                                    width: 250,
                                    decoration:BoxDecoration(
                                        color: Colors.white60.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(color: Colors.white,width: 1.0)
                                    ) ,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${this.widget.teacher.detailsOnExperience!=null?this.widget.teacher.detailsOnExperience:""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: Colors.blueGrey
                                        ),

                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
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
                                    this.widget.teacher.canGo == null
                                        ? ""
                                        : this.widget.teacher.canGo
                                            ? "Can"
                                            : "Can't",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: this.widget.teacher.canGo == null
                                            ? ""
                                            : this.widget.teacher.canGo
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
                  widget.student != null
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
                                            widget.teacher,
                                            this.widget.auth,
                                            this.widget.googleSignIn)));
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
                                        builder: (context) => Lessons(widget.teacher,
                                            this.widget.auth, this.widget.googleSignIn)));
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
                              onPressed: ()async {
                                List<dynamic> cities=  await Userbg.getCities();
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            EditProfileForTeacher(cities:cities,
                                              teacher: widget.teacher,
                                              googleSignIn: this.widget.googleSignIn,
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
          auth: this.widget.auth,
          googleSignin: this.widget.googleSignIn,
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
                  s: widget.student,
                  selectedSubject: widget.subject,
                  selectedLocation: widget.location
             , teacherCan: this.showvalue,)));
        });
  }
}
