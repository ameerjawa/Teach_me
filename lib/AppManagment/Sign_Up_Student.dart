

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';

import '../DBManagment/firebase.dart';




class Sign_Up_Student extends StatefulWidget {
  @override
  _Sign_up_student createState() => _Sign_up_student();
}

class _Sign_up_student extends State<Sign_Up_Student> {
  bool isMale=true;
  final dateController = TextEditingController();
  String studentfullname, phonenumber, location,grade;
  CollectionReference Students = FirebaseFirestore.instance.collection("Students");
  final _auth= FirebaseAuth.instance;
  File image;
  bool isTeacher=false;




  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),

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
                SizedBox(height: 20,),
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
                            height: 11,
                          ),
                          Icon(Icons.book, size: 110, color: Colors.black),
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
                        : NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                  ),
                ),

                SizedBox(height: 40,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    studentfullname = value;
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
                    phonenumber = value;
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
                    location = value;
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
                SizedBox(height: 10,)
                ,
                TextField(

                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    grade = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white60,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0)
                    ),
                    hintText: 'enter your grade',
                    hintStyle: TextStyle(
                      color: const Color(0xCB101010),
                      fontSize: null,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Center(

                        child: Row(
                          children: [
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

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(


                                  child: Row(

                                    children: [

                                      FlatButton(onPressed: (){
                                        color: isMale ? Colors.blue : Colors.green;
                                        setState(() {
                                          isMale=true;

                                        });



                                      }, child: Text('Male'),
                                        color: isMale ? Colors.blue : Colors.green,),
                                      FlatButton(onPressed: (){


                                        setState(() {
                                          isMale=false;
                                        });

                                      }, child: Text('Female')
                                        ,color: isMale ?  Colors.green : Colors.blue,
                                      )

                                    ],
                                  )
                              ),
                            ),

                          ] ,
                        ),
                      ),
                    ),
                  ],
                ),

                  Center(
                      child:


                    IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: ()async {
                          isTeacher=false;
                          Student newStudent = Student(_auth.currentUser.email, "", "", studentfullname, dateController.text, phonenumber, location, isMale);
                          await newStudent.signUpASStudent(newStudent,Students);
                          if (image != null ){
                            String  userId =  _auth.currentUser.uid.toString();
                            uploadImagetofireStorage(image,studentfullname,userId);
                          }
                          Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (context) => StudentActivity()
                          ));
                        }
                    ),)
                 ] )





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


