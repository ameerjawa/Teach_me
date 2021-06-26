import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: must_be_immutable
class SearchForTeacherStudentActivity extends StatefulWidget {
  Student student;
  GoogleSignIn googleSignIn;
  final auth;
  List<dynamic> cities;
  List<dynamic> subjects;

  SearchForTeacherStudentActivity(
      this.student, this.googleSignIn, this.auth, this.subjects,this.cities);

  @override
  SearchForTeacherState createState() => SearchForTeacherState(
  );
}

class SearchForTeacherState extends State<SearchForTeacherStudentActivity> {
  bool showvalue = false;
  var controler = new TextEditingController();
  var controlersecond = new TextEditingController();

  static String selectedSubject;
  String _selectedLocation;


  SearchForTeacherState(
      );

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
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: StudentActivity(
                                        this.widget.student, this.widget.googleSignIn)));
                          }),
                    ],
                  ),
                  Center(
                    child: Column(children: [
                      Container(
                          child: Image.asset("assets/images/newlogologo.jpeg",
                              matchTextDirection: true,
                              height: 160,
                              width: 250)),
                      Text(
                        'TeachMe',
                        style: TextStyle(
                            fontFamily: 'Kaushan',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: <Widget>[
                      Center(
                        child: Text(
                          "Subject",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }
                          // The logic to find out which ones should appear
                          return this.widget.subjects.where((suggestion) => suggestion
                              .toLowerCase()
                              .startsWith(value.text.toLowerCase()));
                        },
                        onSelected: (value) {
                          setState(() {
                            selectedSubject = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "City",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Autocomplete(
                          optionsBuilder: (TextEditingValue value) {
                            // When the field is empty
                            if (value.text.isEmpty) {
                              return [];
                            }

                            // The logic to find out which ones should appear
                            return this.widget.cities.where((suggestion) => suggestion
                                .toLowerCase()
                                .startsWith(value.text.toLowerCase()));
                          },
                          onSelected: (value) {
                            setState(() {
                              _selectedLocation = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "just Teachers who \ncan come to your home",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: this.showvalue,
                          onChanged: (bool value) {
                            setState(() {
                              this.showvalue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  IconButton(
                      icon: const Icon(Icons.done),
                      iconSize: 50,
                      alignment: Alignment.bottomCenter,
                      onPressed: () async {



                        Navigator.of(context).pushReplacement(ScaleRoute(
                            page: SearchForTeacherViewTeachers(
                          auth: this.widget.auth,
                          selectedSubject: selectedSubject,
                          selectedLocation: _selectedLocation,
                          s: this.widget.student,
                          googleSignIn: this.widget.googleSignIn,
                              teacherCan: this.showvalue,
                        )));
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
