import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_me/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';

// ignore: must_be_immutable
class SignUpStudent extends StatefulWidget {
  final Student student;
  List<dynamic> citiesList;
  final  GoogleSignIn googleSignIn;

  final auth;

  SignUpStudent({Key key, this.student, this.citiesList,this.auth,this.googleSignIn}) : super(key: key);

  @override
  SignUpStudentState createState() =>
      SignUpStudentState(student, this.citiesList);
}

class SignUpStudentState extends State<SignUpStudent> {
  bool isMale = true;
  final dateController = TextEditingController();
  String studentfullname, phonenumber, location;
  CollectionReference students =
      FirebaseFirestore.instance.collection("Students");
  File image;
  bool isTeacher = false;
  String googlePhotoUrl;
  GoogleSignIn googleSignIn;
  Student student;
  List<dynamic> citiesList;
  final _formKey = GlobalKey<FormState>();

  SignUpStudentState(this.student, this.citiesList);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(page: AccountType(auth: widget.auth,googleSignIn: this.googleSignIn,)));
                          }),
                      Column(
                        children: [
                          Container(
                              child: SvgPicture.asset(
                                  "assets/images/bookimage.svg",
                                  allowDrawingOutsideViewBox: true,
                                  matchTextDirection: true,
                                  color: Colors.blue.shade900,
                                  height: 100,
                                  width: 200)),
                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontFamily: 'Kaushan',
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                Text(
                  'sign up as Student',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                ),
                Text(
                  'Personal information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: image != null
                        ? FileImage(image)
                        : googlePhotoUrl != null
                            ? NetworkImage(googlePhotoUrl)
                            : NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "Must Type FullName";
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          studentfullname = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: "FullName",
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          phonenumber = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: "Phone Number",
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("City"),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }

                          // The logic to find out which ones should appear
                          return this.citiesList.where((suggestion) =>
                              suggestion
                                  .toLowerCase()
                                  .startsWith(value.text.toLowerCase()));
                        },
                        onSelected: (value) {
                          setState(() {
                            location = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    width: 130,
                                    child: TextFormField(
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
                                        dateController.text = value;
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.white60,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    15.0)),
                                        hintText: 'Birth Date',
                                        hintStyle: InputTextStyle,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                        child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: isMale
                                                  ? Colors.green
                                                  : Colors.blue),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isMale = true;
                                              });
                                            },
                                            child: Text('Male'),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: isMale
                                                  ? Colors.blue
                                                  : Colors.green),
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isMale = false;
                                                });
                                              },
                                              child: Text('Female')),
                                        )
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      iconSize: 50,
                      alignment: Alignment.topLeft,
                      onPressed: () async {
                        try {
                          if (_formKey.currentState.validate()) {
                            isTeacher = false;

                            String userEmail = widget.auth.currentUser.email;
                            String userId = widget.auth.currentUser.uid.toString();
                            Student newStudent = Student(
                                userEmail,
                                "",
                                "",
                                studentfullname,
                                dateController.text,
                                phonenumber,
                                location,
                                isMale);
                            newStudent.signUpASStudent(
                                newStudent, students, userId);

                            if (image != null) {
                              Userbg.uploadImage(
                                  image, studentfullname, userId);
                            }
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: StudentActivity(
                                        newStudent, googleSignIn)));
                          }
                        } catch (e) {
                          print(
                              "somthing wrong with sign up the student line 326 SignUpAsStudent");
                        }
                      }),
                )
              ])),
        ),
      ),
    );
  }

  // private function thet get image from user gallery in his device
  Future<void> _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
}
