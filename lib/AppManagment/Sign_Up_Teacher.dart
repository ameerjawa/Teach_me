import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'file:///D:/ameer/teach_me/lib/DBManagment/firebase.dart';

import 'TeacherlessionsDetails.dart';
import 'sign_in.dart';



class Sign_Up_Teacher extends StatefulWidget {
  @override
  _Sign_Up_TeacherState createState() => _Sign_Up_TeacherState();
}

class _Sign_Up_TeacherState extends State<Sign_Up_Teacher> {
  File imageFile;
  final dateController = TextEditingController();
  String TeacherFullName,PhoneNumber,Location,BirthDate;
  final databaseReference = FirebaseDatabase.instance.reference();
  CollectionReference Teachers = FirebaseFirestore.instance.collection("Teachers");
  final _auth= FirebaseAuth.instance;
  bool isTeacher=true;



  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (context) => AccountType()
                          ));
                        }
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Icon(Icons.book, size: 110, color: Colors.white),
                          Text(
                            'TeachMe',
                            style: TextStyle(
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
                    SizedBox(height: 40,),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                          TeacherFullName =value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          color: const Color(0xCB101010),
                          fontSize: null,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),


                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(

                      textAlign: TextAlign.center,
                      onChanged: (value) {
                      PhoneNumber=value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: const Color(0xCB101010),
                          fontSize: null,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),


                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(

                      textAlign: TextAlign.center,
                      onChanged: (value) {
                            Location = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),
                        hintText: 'Location',
                        hintStyle: TextStyle(
                          color: const Color(0xCB101010),
                          fontSize: null,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),



                           Container(
                             width: 130,
                             child: TextField(

                              readOnly: true,
                              controller: dateController,
                              textAlign: TextAlign.center,
                               onTap: () async{
                                 var date =  await showDatePicker(
                                     context: context,
                                     initialDate:DateTime.now(),
                                     firstDate:DateTime(1900),
                                     lastDate: DateTime(2100));
                                 dateController.text = date.toString().substring(0,10);
                                  },
                              onChanged: (value) {
                                     dateController.text=value;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white60,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                ),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(

                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                iconSize: 50,

                                alignment: Alignment.topLeft,
                                onPressed: () async {

                                Teacher newTeacher = Teacher(_auth.currentUser.email, "", "", TeacherFullName, dateController.text, PhoneNumber, Location, [], "");
                                await newTeacher.signUpASTeacher(newTeacher,Teachers);

                                if (imageFile != null ){
                                  String  userId =  _auth.currentUser.uid.toString();
                                  uploadImagetofireStorage(imageFile,TeacherFullName,userId);
                                }
                                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                builder: (context) => TeacherlessionsDetail()
                                ));

                                }
                              ),
                              Text(
                                'Next',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),

                        ]),



                  ],
                ),
              ]),
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

  Future<void> _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
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
