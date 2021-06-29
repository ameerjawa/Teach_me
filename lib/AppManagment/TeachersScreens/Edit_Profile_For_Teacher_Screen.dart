import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';
import 'Update_Lesson_information_Screen.dart';

// ignore: must_be_immutable
class EditProfileForTeacher extends StatefulWidget {
  Teacher teacher;
  final auth;
  GoogleSignIn googleSignIn;
  List<dynamic> cities;

  EditProfileForTeacher(
      {Key key, this.teacher, this.auth, this.googleSignIn, this.cities})
      : super(key: key);

  @override
  EditProfileForTeacherState createState() => EditProfileForTeacherState();
}

class EditProfileForTeacherState extends State<EditProfileForTeacher> {
  File imageFile;
  final _dateController = TextEditingController();
  String fullName, phoneNumber, location, date;
  bool _validate = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  CollectionReference teachers =
      FirebaseFirestore.instance.collection("Teachers");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  EditProfileForTeacherState();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Student s;

                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: TeacherHomepage(
                                  this.widget.teacher,
                                  s,
                                  "",
                                  "",
                                  this.widget.auth,
                                  this.widget.googleSignIn,
                                  false)));
                        }),
                    Column(
                      children: [
                        Image.asset("assets/images/newlogologo.jpeg",
                            matchTextDirection: true, height: 80, width: 120),
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
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Edit Your Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Personal information',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(100)),
                    child: GestureDetector(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile)
                            : NetworkImage(this.widget.teacher.proImg),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("${this.widget.teacher.email}"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white60,
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      hintText: 'Full Name',
                      hintStyle: InputTextStyle,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white60,
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      hintText: 'Phone Number',
                      hintStyle: InputTextStyle,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "City",
                      style: InputTextStyle,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black54),
                        borderRadius: new BorderRadius.circular(15.0),
                        color: Colors.white60),
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
                          location = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 130,
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      textAlign: TextAlign.center,
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        _dateController.text = date.toString().substring(0, 10);
                      },
                      onChanged: (value) {
                        _dateController.text = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        errorText: _validate ? 'Type Date!' : null,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        hintText: 'Birth Date',
                        hintStyle: InputTextStyle,
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Column(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                iconSize: 50,
                                alignment: Alignment.topLeft,
                                onPressed: () async {
                                  try {
                                    String userId = this.widget.teacher.id;
                                    String url = "";
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(new SnackBar(
                                      duration: new Duration(seconds: 5),
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

                                    if (imageFile != null) {
                                      url = await Userbg.uploadImage(
                                          imageFile, fullName, userId);
                                    }

                                    fullName = fullName != null
                                        ? fullName
                                        : this.widget.teacher.fullName;
                                    phoneNumber = phoneNumber != null
                                        ? phoneNumber
                                        : this.widget.teacher.phoneNumber;

                                    location = location != null
                                        ? location
                                        : this.widget.teacher.location;

                                    date = _dateController.text != null
                                        ? _dateController.text
                                        : this.widget.teacher.birthDate;
                                    url = url == ""
                                        ? this.widget.teacher.proImg
                                        : url;

                                    Map<String, dynamic> data = {
                                      "FullName": fullName,
                                      "PhoneNumber": phoneNumber,
                                      "Location": location,
                                      "BirthDate": date,
                                      "ProfileImg": url
                                    };
                                    await this
                                        .widget
                                        .teacher
                                        .updateTeacherDetails(data, userId);

                                    List<dynamic> subjectsList =
                                        await Userbg.getSubjects();

                                    Navigator.of(context)
                                        .pushReplacement(SlideRightRoute(
                                            page: EditLessonInformation(
                                      teacher: this.widget.teacher,
                                      googleSignIn: this.widget.googleSignIn,
                                      subjects: subjectsList,
                                    )));
                                  } catch (e) {
                                    print(
                                        "something went wrong in next Button line 323 Edit Profile AS Teacher Screen");
                                  }
                                }),
                            Text(
                              'Next',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
