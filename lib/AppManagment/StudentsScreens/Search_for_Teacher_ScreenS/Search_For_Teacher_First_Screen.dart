import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import '../../UsersScreens/checkInternet.dart';

// ignore: must_be_immutable
class SearchForTeacherStudentActivity extends StatefulWidget {

  Student student;
  GoogleSignIn googleSignIn;
  final auth;
  List<dynamic> cities;
  List<dynamic> subjects;

  SearchForTeacherStudentActivity(
      this.student, this.googleSignIn, this.auth, this.subjects, this.cities);

  @override
  SearchForTeacherState createState() => SearchForTeacherState();
}

class SearchForTeacherState extends State<SearchForTeacherStudentActivity> {
  bool showvalue = false;
  var controler = new TextEditingController();
  var controlersecond = new TextEditingController();

  static String selectedSubject;
  String _selectedLocation;

  SearchForTeacherState();
  // void initState(){
  //   super.initState();
  //   CheckInternet().checkConnection(context);
  // }
  // @override
  // void dispose() {
  //   CheckInternet().listener.cancel();
  //   super.dispose();
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: lRPadding + 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: lRPadding * 2.5,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: StudentActivity(student:this.widget.student,
                                googleSignIn: this.widget.googleSignIn)));
                      }),
                ],
              ),
              Center(
                child: Column(children: [
                  Container(
                      child: Image.asset("assets/images/newlogologo.jpeg",
                          matchTextDirection: true,
                          height: lRPadding * 8,
                          width: lRPadding * 12.5)),
                  Text(
                    'TeachMe',
                    style: TextStyle(
                        fontFamily: 'Kaushan',
                        fontWeight: FontWeight.bold,
                        fontSize: lRPadding * 1.5,
                        color: Colors.white),
                  ),
                ]),
              ),
              SizedBox(
                height: lRPadding * 3.5,
              ),
              Padding(
                padding: const EdgeInsets.all(lRPadding - 5),
                child: Column(children: <Widget>[
                  Center(
                    child: Text(
                      "Subject",
                      style:
                          TextStyle(color: Colors.black, fontSize: lRPadding),
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
                      return this.widget.subjects.where((suggestion) =>
                          suggestion
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
                    height: lRPadding / 2,
                  ),
                  Center(
                    child: Text(
                      "City",
                      style:
                          TextStyle(color: Colors.black, fontSize: lRPadding),
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
                        return this.widget.cities.where((suggestion) =>
                            suggestion
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
                    height: lRPadding,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(lRPadding - 5),
                child: Row(
                  children: [
                    Text(
                      "just Teachers who \ncan come to your home",
                      style: TextStyle(
                        fontSize: lRPadding,
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
                height: lRPadding * 2.5,
              ),
              IconButton(
                  icon: const Icon(Icons.done),
                  iconSize: lRPadding * 2.5,
                  alignment: Alignment.bottomCenter,
                  onPressed: () async {
                    try {
                      Navigator.of(context).pushReplacement(SlideRightRoute(
                          page: SearchForTeacherViewTeachers(
                        auth: this.widget.auth,
                        selectedSubject: selectedSubject,
                        selectedLocation: _selectedLocation,
                        s: this.widget.student,
                        googleSignIn: this.widget.googleSignIn,
                        teacherCan: this.showvalue,
                      )));
                    } catch (e) {
                      print(
                          "something wrong with navigator to SearchForTeacherViewTeachers class in line 200 SearchForTeacherFirstScreen ");
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
