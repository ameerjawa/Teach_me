

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teach_me/AppManagment/Lessons.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/AppManagment/search_for_teacher_viewTeachers.dart';
import 'package:teach_me/AppManagment/sign_in.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/routes/pageRouter.dart';




class Teacher_Homepage extends StatefulWidget {

  DocumentSnapshot isTeacher;
  String subject,location;
  Student student;
  Teacher_Homepage(this.isTeacher,this.student,this.subject,this.location);

  @override
  Homepage_teacherState createState() => Homepage_teacherState(isTeacher,student,subject,location);
}

class Homepage_teacherState extends State<Teacher_Homepage> {

  bool showvalue=false;
  DocumentSnapshot isTeacher;
  String subject,location;
  Student student;
  final _auth = FirebaseAuth.instance;


  Homepage_teacherState(this.isTeacher,this.student,this.subject,this.location);







  Widget build(BuildContext context) {

  String FullName= this.isTeacher.get(FieldPath(["FullName"]));
  String Location= this.isTeacher.get(FieldPath(["Location"]));
  String PhoneNumber= this.isTeacher.get(FieldPath(["PhoneNumber"]));
  String Price= this.isTeacher.get(FieldPath(["Price"]));






   Teacher t = new Teacher("email", "password", "verifyPassword", FullName, "birthDate", PhoneNumber, Location, [], "detailsOnExperience","");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue.shade200
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),

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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children:[
                            student!=null?showButton(context):showLogoutButton(context),

                            Text("Back To Results",
                                style: TextStyle(
                                  fontSize: 12
                                ),
                            ),
                          ]
                        ),

                        Column(
                            children: [
                              SizedBox(
                                height: 11,
                              ),
                              Icon(Icons.book, size:70, color: Colors.black),
                              Text(
                                'TeachMe',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.black),
                              ),  ]),



                      ],
                    ),
                  ),


                  SizedBox(height: 30,),
                  Text(this.isTeacher["FullName"],
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white),
                   ),
                  SizedBox(height: 10,),
                  Text("${this.isTeacher["subjects"]} Teacher ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  SingleChildScrollView(
                    child: Container(

                      height: 440 ,
                     width: 300,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white54
                     ),

                     // color: Colors.grey,

                      child: Column(

                        children: [
                          RatingBarIndicator(
                            rating: isTeacher["Rating"],
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(height: 30,),

                          // Text('Still have no lessons',
                          //       style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 15,
                          //       color: Colors.black),),


                          Text(
                            "City : ${this.isTeacher["Location"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(
                              "PhoneNumber :  ${this.isTeacher["PhoneNumber"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(
                              "More About Me : ${this.isTeacher["More"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 100,)
                          ,   Row(
                              children:<Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Can Go To Student ?'
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(


                                      child: Row(

                                        children: [

                                          // ignore: deprecated_member_use
                                          FlatButton(child: Text(
                                      this.isTeacher["CanGo"] ? "Can" : "Can't"
                                              ,style: TextStyle(
                                            fontSize: 30,
                                            color: this.isTeacher["CanGo"] ? Colors.green : Colors.red)
                                          ),),



                                        ],
                                      )
                                  ),
                                ),
                              ]

                          ),

                        ],
                      ),
                    ),
                  ),
                  student!=null? Container(
                    height: 170
                  ):Column(
                    children: [
                      SizedBox(height: 20,),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                          backgroundColor: Colors.grey,

                        ),
                        onPressed: () { },
                        child: Text('Search For Student',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,),),
                      ),
                      SizedBox(height: 20,),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blue,

                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {

                          Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (context) => Lessons(isTeacher)
                          ));
                        },
                        child: Text('Lessons',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),),
                      ),
                      SizedBox(height: 40,),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blue,

                        ),
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          //     builder: (context) => sign_in()
                          // ));
                        },
                        child: Text('edit profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),),
                      ),
                    ],
                  )




                ]),
          ),
        ),
      ),
    );
  }
  showLogoutButton(BuildContext context){
    return  IconButton(
        icon: const Icon(Icons.logout),
        iconSize: 50,
      onPressed: ()=>showDialog(
        context: context,
        builder: (context) => SureLogout(auth:_auth),

      ),

    );

  }

  Widget showButton(BuildContext context ){
    return  IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => search_for_teacher_viewTeachers(s: student,selectedSubject: subject, selectedLocation: location)
          ));
        }

    );

  }



}




