import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';




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

import 'PdfViewer_Screen.dart';

// ignore: must_be_immutable
class TeacherHomepage extends StatefulWidget {
  Teacher teacher;
  String subject, location;
  Student student;
  final auth;
  bool showvalue;
  GoogleSignIn googleSignIn;

  TeacherHomepage(this.teacher, this.student, this.subject, this.location,
      this.auth, this.googleSignIn, this.showvalue);

  @override
  HomepageteacherState createState() => HomepageteacherState();
}

class HomepageteacherState extends State<TeacherHomepage> {
  bool showvalue = false;
  String subjectsintext = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String remotePDFpath="";
  PDFDocument doc;

  HomepageteacherState();


  @override
  void initState(){
    super.initState();



  }

  Future<File> createFileOfPdfUrl(String url) async {
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";

      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/Certifecation.pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

  }

  Widget build(BuildContext context) {

    subjectsintext = "";
    for (int i = 0; i < this.widget.teacher.subjects.length; i++) {
      if (this.widget.teacher.subjects.length >= 4 && i % 3 == 0) {
        subjectsintext += "\n";
      }
      subjectsintext += "${this.widget.teacher.subjects[i].toString()} ";
      if (i != this.widget.teacher.subjects.length - 1) {
        subjectsintext += ",";
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
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
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(this.widget.teacher.proImg),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Text(
                        this.widget.teacher.fullName != null
                            ? this.widget.teacher.fullName
                            : "name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: BtnFont),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${subjectsintext != null ? subjectsintext : ""} ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Rating",
                              style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: InputFontSize),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: RatingBarIndicator(
                            rating: this.widget.teacher.rating != null
                                ? this.widget.teacher.rating
                                : 0.0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        Center(
                          child: Text(
                            this.widget.teacher.titleSentence != null
                                ? this.widget.teacher.titleSentence
                                : "",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "City : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                  Text(
                                    " ${this.widget.teacher.location != null ? this.widget.teacher.location : ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Phone :  ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                  Text(
                                    "${this.widget.teacher.phoneNumber != null ? this.widget.teacher.phoneNumber : ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Times New Roman'),
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
                                      fontSize: 20,
                                      fontFamily: 'Times New Roman'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  height: 140,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white60.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.white, width: 1.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${this.widget.teacher.detailsOnExperience != null ? this.widget.teacher.detailsOnExperience : ""}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.blueGrey),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(child: Text("Certifecations"),
                            onPressed: ()async{
                              print("amr");




                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) => PDFScreen(path:this.widget.teacher.fileUrl)));
                             },)
                          ],
                        ),
                      ],
                    ),
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
                          onPressed: () async {
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
                                    builder: (context) => Lessons(
                                        widget.teacher,
                                        this.widget.auth,
                                        this.widget.googleSignIn)));
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
                          onPressed: () async {
                            try {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(new SnackBar(
                                duration: new Duration(seconds: 2),
                                content: new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    new Text(" Moving ")
                                  ],
                                ),
                              ));
                              List<dynamic> cities = await Userbg.getCities();
                              print(widget.teacher.id);
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          EditProfileForTeacher(
                                            cities: cities,
                                            teacher: widget.teacher,
                                            googleSignIn:
                                                this.widget.googleSignIn,
                                          )));
                            } catch (e) {
                              print(
                                  "something went wrong in Edit Profile Button TeacherHomePage line 404");
                            }
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
                    selectedLocation: widget.location,
                    teacherCan: this.showvalue,
                  )));
        });
  }
}
