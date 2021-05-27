import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';

import '../DBManagment/firebase.dart';

class Sign_Up_Student extends StatefulWidget {
  final Student student;

  const Sign_Up_Student({Key key, this.student}) : super(key: key);

  @override
  _Sign_up_student createState() => _Sign_up_student(student);
}

class _Sign_up_student extends State<Sign_Up_Student> {
  bool isMale = true;
  final dateController = TextEditingController();
  String studentfullname, phonenumber, location, grade;
  CollectionReference Students =
      FirebaseFirestore.instance.collection("Students");
  final _auth = FirebaseAuth.instance;
  File image;
  bool isTeacher = false;
  String googlePhotoUrl;
  Student student;
  List Locations = ["all", "Haifa", "TelAviv", "faradis", "BatYam"];
  final _formKey = GlobalKey<FormState>();

  _Sign_up_student(this.student);

  Widget build(BuildContext context) {
    // if (this._userObj!=null){
    //   setState(() {
    //    googlePhotoUrl=_userObj.photoUrl;
    //   });
    // }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blue.shade200),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                                    SlideRightRoute(page: AccountType()));
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
                        getFromGallery();
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
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),

                              //_userObj != null?_userObj.displayName:
                              hintText: "FullName",
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(

                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              phonenumber = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
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
                              return Locations.where((suggestion) => suggestion
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
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Must Type grade";
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              grade = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              hintText: 'enter your grade',
                              hintStyle: TextStyle(
                                color: const Color(0xCB101010),
                                fontSize: null,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
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
                                            dateController.text = date
                                                .toString()
                                                .substring(0, 10);
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
                                            hintStyle: TextStyle(
                                              color: const Color(0xCB101010),
                                              fontSize: null,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                            child: Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                color:
                                                isMale
                                                    ? Colors.green
                                                    : Colors.blue;
                                                setState(() {
                                                  isMale = true;
                                                });
                                              },
                                              child: Text('Male'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  color:
                                                  isMale
                                                      ? Colors.blue
                                                      : Colors.green;

                                                  setState(() {
                                                    isMale = false;
                                                  });
                                                },
                                                child: Text('Female'))
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
                            if (_formKey.currentState.validate()) {
                              isTeacher = false;
                              //_userObj.displayName
                              // studentfullname==null?studentfullname=studentfullname:studentfullname;
                              String userEmail = _auth.currentUser.email;
                              String userId = _auth.currentUser.uid.toString();
                              // userEmail ==null? userEmail:userEmail;
                              Student newStudent = Student(
                                  userEmail,
                                  "",
                                  "",
                                  studentfullname,
                                  dateController.text,
                                  phonenumber,
                                  location,
                                  isMale);
                              await newStudent.signUpASStudent(
                                  newStudent, Students, userId);

                              if (image != null) {
                                uploadImagetofireStorage(
                                    image, studentfullname, userId);
                              }
                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: StudentActivity(newStudent,)));
                            }
                          }),
                    )
                  ])),
        ),
      ),
    );
  }

  Future<void> getFromGallery() async {
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
