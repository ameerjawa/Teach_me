// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'Subjects_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Teacher_Home_Page_Screen.dart';

// ignore: must_be_immutable
class TeacherLessonDetail extends StatefulWidget {
  Teacher teacher;
  GoogleSignInAccount userObj;
  GoogleSignIn googleSignin;
  List<dynamic> subjects;
  final auth;
  List<Subject> selectedSubjectsModel = [];

  TeacherLessonDetail(
      {Key key,
      this.teacher,
      this.userObj,
      this.auth,
      this.googleSignin,
      this.subjects})
      : super(key: key);

  @override
  TeacherlessionsDetails createState() => TeacherlessionsDetails(
     );
}

class TeacherlessionsDetails extends State<TeacherLessonDetail> {
  String titleSentence,
      moreDetails,

      selectedSubject,
      selectedsubjectstext;
  int price;
  bool canGo = false;
  final _formKey = GlobalKey<FormState>();
  List<Subject> temp = [];

  TeacherlessionsDetails(
    );

  Widget build(BuildContext context) {
    CollectionReference teachers =
        FirebaseFirestore.instance.collection("Teachers");

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Icon(Icons.book, size: 110, color: Colors.white),
                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontFamily: 'Kaushan',
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Lessions Information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ListTile(
                          onTap: () async {
                            final List<Subject> _response =
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubjectsScreen(this.widget.subjects)));
                            setState(() {
                              temp = _response;
                              selectedsubjectstext =
                                  temp.map((e) => e.name).join(", ");
                            });
                          },
                          title: Text(
                            selectedsubjectstext != null &&
                                    selectedsubjectstext != ""
                                ? "$selectedsubjectstext"
                                : "subjects",
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(Icons.arrow_drop_down),
                        ),

                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "your Profile look better with Title sentence";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              titleSentence = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              hintText: 'Enter a Title Sentence',
                              hintStyle: InputTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                moreDetails = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 75.0, horizontal: 10.0),
                                fillColor: Colors.white60,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                hintText: 'More About you',
                                hintStyle: InputTextStyle,
                              ),
                            ),
                          ),
                          Row(children: <Widget>[
                            Text('Can You Go to Student House ?'),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  child: Row(
                                children: [
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        canGo = !canGo;
                                      });
                                    },
                                    child: Text('Can'),
                                    color: canGo ? Colors.red : Colors.green,
                                  ),
                                ],
                              )),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  height: 70,
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty || value == null) {
                                        return "Must Type Price";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      price = value as int;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 10.0),
                                      fillColor: Colors.white60,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0)),
                                      hintText: 'Price',
                                      hintStyle: InputTextStyle,
                                    ),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      iconSize: 50,
                                      alignment: Alignment.topLeft,
                                      onPressed: () async {
                                        try{
                                          if (_formKey.currentState.validate()) {
                                            // TODO submit

                                            String userId = widget.userObj != null
                                                ? widget.userObj.id
                                                : this.widget.auth != null
                                                ? this.widget.auth
                                                .currentUser
                                                .uid
                                                .toString()
                                                : "";


                                            List<String> finalsubjects = [];
                                            for (int j = 0;
                                            j < temp.length;
                                            j++) {
                                              finalsubjects.add(temp[j].name);
                                            }


                                            Map<String, dynamic> data = {
                                              "subjects": finalsubjects,
                                              "Title Sentence": titleSentence,
                                              "More": moreDetails,
                                              "Price": price,
                                              "CanGo": canGo
                                            };

                                            await this.widget.teacher.moreTeacherDet(
                                                data, teachers, userId);

                                            Student s;
                                            Navigator.of(context).pushReplacement(
                                                SlideRightRoute(
                                                    page: TeacherHomepage(
                                                        this.widget.teacher,
                                                        s,
                                                        "",
                                                        "",
                                                        this.widget.auth,
                                                        this.widget.googleSignin,
                                                        false)));
                                          }
                                        }catch(e){
                                          print("something went wrong with Next Button in SignUpLessonDetailsScreen");
                                        }

                                      }),
                                  Text(
                                    'Next',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ]),
                      )
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

