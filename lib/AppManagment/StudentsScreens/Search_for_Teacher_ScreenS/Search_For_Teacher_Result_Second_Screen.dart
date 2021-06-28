

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';
import 'Search_For_Teacher_First_Screen.dart';
import 'Teacher_List_Component.dart';



// ignore: must_be_immutable
class SearchForTeacherViewTeachers extends StatefulWidget {
  String selectedSubject;
  String selectedLocation;
  GoogleSignIn googleSignIn;
  Student s;
  bool teacherCan;
  List<Teacher> teachers;
  final auth;
  SearchForTeacherViewTeachers({ @required this.selectedSubject,@required this.selectedLocation,this.s,this.teachers,this.googleSignIn,this.auth,this.teacherCan}) : super();
  SearchForTeacherState createState() => SearchForTeacherState();


}

class SearchForTeacherState extends State<SearchForTeacherViewTeachers> {

  List<Teacher> teachersResult;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  SearchForTeacherState() : super();


  Widget build(BuildContext context)  {

    return Scaffold(
      key: _scaffoldKey,


      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),




              child: SingleChildScrollView(
                child: Column(

                    children: <Widget>[
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 50,
                                alignment: Alignment.topLeft,
                                onPressed: ()async {

                                  try{
                                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                      duration: new Duration(seconds: 3),
                                      content: new Row(
                                        children: <Widget>[
                                          new CircularProgressIndicator(),
                                          SizedBox(
                                            width: lRPadding*1.5,
                                          ),
                                          new Text(" Moving to Search For Teacher ")
                                        ],
                                      ),
                                    ));
                                    List<dynamic> subjectsList= await Userbg.getSubjects();
                                    List<dynamic> citiesList=await Userbg.getCities();
                                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                        builder: (context) => SearchForTeacherStudentActivity(this.widget.s,this.widget.googleSignIn,this.widget.auth,subjectsList,citiesList)

                                    ));
                                  }catch(e){
                                    print("problem with getting the subjects or the cities or navigator in line 92 Search_For_Teacher_Result_Second_Screen.dart");
                                  }

                                }
                            ),

                             Column(
                                  children: [
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 50,width: 120),
                                    Text(
                                      'TeachMe',
                                      style: TextStyle(
                                          fontFamily: 'Kaushan',

                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),  ]),


                          ],
                        ),
                      ),


                     Padding(
                       padding: const EdgeInsets.all(15.0),
                       child: Column(
                         children: [
                           Text(this.widget.selectedSubject != null?this.widget.selectedSubject:"Subject",
                           style: TextStyle(
                             color: Colors.blue,
                             fontSize: 50,
                             fontWeight: FontWeight.bold
                           ),),
                           Text("Here You Can Find Very Professional ${this.widget.selectedSubject} Teachers"),
                         ],
                       ),
                     ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(

                  ),

                )
,


                   SingleChildScrollView(child: Container(height: 500,child: TeachersList(this.widget.selectedSubject,this.widget.selectedLocation,this.widget.s,this.widget.auth,this.widget.googleSignIn,this.widget.teacherCan)))



                    ]),
              ),


          ),
      ),

    );
  }
}







