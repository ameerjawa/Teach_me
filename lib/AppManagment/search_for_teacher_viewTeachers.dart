

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teach_me/AppManagment/Teacher_Homepage.dart';
import 'package:teach_me/AppManagment/search_for_teacher_StudentActivity.dart';
import 'package:teach_me/DBManagment/firebase.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'search_for_teacher_StudentActivity.dart';



class search_for_teacher_viewTeachers extends StatefulWidget {
  @override
  String selectedSubject;
  String selectedLocation;
  Student s;
  List<Teacher> teachers;
  search_for_teacher_viewTeachers({ @required this.selectedSubject,@required this.selectedLocation,this.s,this.teachers}) : super();
  _SearchforTeacherState createState() => _SearchforTeacherState(selectedSubject:this.selectedSubject,selectedLocation: this.selectedLocation ,s:this.s,teachers: this.teachers);


}

class _SearchforTeacherState extends State<search_for_teacher_viewTeachers> {
  bool showvalue=false;
  String selectedSubject;
  String selectedLocation;
  Student s;
  List<Teacher> teachers;
  List<Teacher> teachersResult;

  _SearchforTeacherState({ @required this.selectedSubject,@required this.selectedLocation,this.s,this.teachers}) : super();


  Widget build(BuildContext context)  {
// this.teachers.then((value) => {
//   value.forEach((element)  {
//     teachersResult.add(element);
//   })
// });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(5.0),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.


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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 50,
                            alignment: Alignment.topLeft,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => search_for_teacher_StudentActivity(this.s)

                              ));
                            }
                        ),

                         Column(
                              children: [
                                SizedBox(
                                  height: 11,
                                ),
                                Icon(Icons.book, size: 60, color: Colors.black),
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


                  SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     children: [
                       Text(selectedSubject != null?selectedSubject:"Subject",
                       style: TextStyle(
                         color: Colors.blue,
                         fontSize: 50,
                         fontWeight: FontWeight.bold
                       ),),
                       Text("Here You Can Find Very Professional ${selectedSubject} Teachers"),
                     ],
                   ),
                 ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i=0 ; i<4 ; i++)
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: Text('point ${(i+3)}'),
                    ),
                  ]
                ),
              ),

            )
,


               SingleChildScrollView(child: Container(height:500,child: TeachersList(this.selectedSubject,this.selectedLocation,this.s)))



                ]),


        ),

    );
  }
}






class TeachersList extends StatefulWidget  {

  String subject;
  String location;
  Student student;

  TeachersList(this.subject,this.location,this.student);

  @override
  _TeachersListState createState() => _TeachersListState(student,subject,location);
}

class _TeachersListState extends State<TeachersList> {


  String subject;
  String location;
  Student student;
  _TeachersListState(this.student,this.subject,this.location);
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new StreamBuilder<QuerySnapshot>(
      stream:this.widget.location=="all" && this.widget.subject=="all"? FirebaseFirestore.instance.collection('Teachers').snapshots():FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: this.widget.location).where("subjects",isEqualTo: this.widget.subject).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {

            return new ListTile(  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                onTap: (){
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (context) => Teacher_Homepage(document,this.student,this.subject,this.location)
                  ));
                },
                leading: Container(

                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                  child: GestureDetector(

                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: document["ProfileImg"] != null
                       ?NetworkImage(document["ProfileImg"])
                          : NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                    ),
                  ),
                ),
                title: Text(
                  document["FullName"],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      rating: document["Rating"],
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 5.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 5,),
                    Text(document["subjects"], style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
            );
          }).toList(),
        );
      },
    );
  }


}


