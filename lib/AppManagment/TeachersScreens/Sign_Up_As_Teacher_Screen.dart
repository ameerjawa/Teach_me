import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_me/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/User/Userbg.dart';
import 'package:path/path.dart';


import 'Sign_Up_Lessions_Details_Screen.dart';

// ignore: must_be_immutable
class SignUpTeacher extends StatefulWidget {
  final GoogleSignInAccount userObj;
  final  GoogleSignIn googleSignIn;

  final auth;

  List<dynamic> cities;

  SignUpTeacher({Key key, this.userObj, this.auth, this.cities,this.googleSignIn})
      : super(key: key);

  @override
  SignUpTeacherState createState() => SignUpTeacherState();
}

class SignUpTeacherState extends State<SignUpTeacher> {
  File imageFile;
  final dateController = TextEditingController();
  String teacherFullName, phoneNumber, location, birthDate;
  final databaseReference = FirebaseDatabase.instance.reference();
  CollectionReference teachers =
      FirebaseFirestore.instance.collection("Teachers");
  bool isTeacher = true;
  final _formKey = GlobalKey<FormState>();
  File file;

  SignUpTeacherState();
  Future selectfile()async{
    var result= await FilePicker.platform.pickFiles();
    if(result==null)return ;
    final path= result.files.single.path;

    setState(() => file=File(path));
  }

  Widget build(BuildContext context) {
    final filename=file!=null?basename(file.path):"no file selected";

    return Scaffold(
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
                          Navigator.of(context).pushReplacement(
                              SlideRightRoute(page: AccountType(auth: widget.auth,googleSignIn: widget.googleSignIn,userObj: widget.userObj,)));
                        }),
                    Text(
                      'TeachMe',
                      style: TextStyle(
                          fontFamily: 'Kaushan',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ]),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'sign up as Teacher',
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
                  GestureDetector(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile)
                          : NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(widget.userObj != null ? widget.userObj.email : ""),
                  SizedBox(
                    height: 10,
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
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            teacherFullName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            hintText: 'Full Name',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Must Type PhoneNumber";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
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
                          style: TextStyle(
                            color: const Color(0xCB101010),
                            fontSize: InputFontSize,
                            fontFamily: InputFont,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        Container(
                          decoration: BoxDecoration(
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
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Must Type BirthDate";
                              }
                              return null;
                            },
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
                                      new BorderRadius.circular(15.0)),
                              hintText: 'Birth Date',
                              hintStyle: InputTextStyle,
                            ),
                          ),
                        ),

                        Container(
                        child:  Column(
                          children: [
                            TextButton(
                              child: Text("Pick a certifecation file"),
                              onPressed: (){
                                selectfile();
                              },


                            ),
                            Text(filename)
                          ],
                        ),


                        )
                      ],
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
                                    if (_formKey.currentState.validate()) {
                                      String userId =
                                          this.widget.userObj == null
                                              ? this
                                                  .widget
                                                  .auth
                                                  .currentUser
                                                  .uid
                                                  .toString()
                                              : this.widget.userObj.id;
                                      String email = this.widget.userObj == null
                                          ? this
                                              .widget
                                              .auth
                                              .currentUser
                                              .email
                                              .toString()
                                          : this.widget.userObj.email;

                                      List<dynamic> subjectsList =
                                          await Userbg.getSubjects();
                                      String fileUrl;


                                      if (imageFile != null) {
                                        Teacher newTeacher;

                                        if(file!=null){

                                          fileUrl=await Userbg.uploadfile(file, teacherFullName, userId);

                                                 }else{
                                          fileUrl="";
                                        }
                                        String imageUrl =
                                            await Userbg.uploadImage(imageFile,
                                                teacherFullName, userId);
                                        newTeacher = Teacher(
                                            email,
                                            "",
                                            "",
                                            teacherFullName,
                                            dateController.text,
                                            phoneNumber,
                                            location,
                                            [],
                                            "",
                                            imageUrl,
                                            1.1,
                                            false,
                                            "",
                                            "",
                                            0,fileUrl);
                                        newTeacher.signUpASTeacher(
                                            newTeacher, teachers, userId);
                                        Navigator.of(context)
                                            .pushReplacement(SlideRightRoute(
                                                page: TeacherLessonDetail(
                                          teacher: newTeacher,
                                          userObj: this.widget.userObj,
                                          auth: this.widget.auth,
                                          subjects: subjectsList,
                                        )));
                                      } else {
                                        if(file!=null){

                                           fileUrl=await Userbg.uploadfile(file, teacherFullName, userId);

                                        }else{
                                          fileUrl="";
                                        }
                                        Teacher newTeacher = Teacher(
                                            email,
                                            "",
                                            "",
                                            teacherFullName,
                                            dateController.text,
                                            phoneNumber,
                                            location,
                                            [],
                                            "",
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU",
                                            1.1,
                                            false,
                                            "",
                                            "",
                                            0,
                                            fileUrl);
                                        newTeacher.signUpASTeacher(
                                            newTeacher, teachers, userId);
                                        Navigator.of(context)
                                            .pushReplacement(SlideRightRoute(
                                                page: TeacherLessonDetail(
                                          teacher: newTeacher,
                                          userObj: this.widget.userObj,
                                          auth: this.widget.auth,
                                          subjects: subjectsList,
                                        )));
                                      }
                                    }
                                  } catch (e) {
                                    print(
                                        "something went wrong in next Button line 378 Sign Up AS Teacher Screen "+e.toString());
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
