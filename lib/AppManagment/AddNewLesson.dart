




// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';

import '../DBManagment/firebase.dart';
import 'AccountType.dart';
import 'Lessons.dart';
import 'Teacher_Homepage.dart';

class AddNewLesson extends StatefulWidget {
  final DocumentSnapshot document;
     // GoogleSignInAccount userObj;
final   DocumentSnapshot isTeacher;


  const AddNewLesson({Key key,this.isTeacher, this.document}) : super(key: key);
  @override
  AddNewLessonState createState() => AddNewLessonState(isTeacher,document);
}

class AddNewLessonState extends State<AddNewLesson> {
  String Lessonsubject,stuPhoneNumber,stuName,time;
  List subjects = ["English","Math","maba","biology","physic","hebrew","arabic"];
  bool CanGo=false;
  // final  GoogleSignInAccount userObj;
  final   DocumentSnapshot isTeacher;
 final  DocumentSnapshot Lessondocument;
  final dateController = TextEditingController();



  AddNewLessonState( this.isTeacher, this.Lessondocument);



  Widget build(BuildContext context) {
    final _auth= FirebaseAuth.instance;
    CollectionReference Teachers = FirebaseFirestore.instance.collection("Teachers");

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(SlideRightRoute(
                                page: Lessons(isTeacher)
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
                SizedBox(height: 40,),
                Center(
                    child: Text(
                      this.Lessondocument!=null?'Edit Lesson':'Add New Lesson',
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    )
                ),



                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [


                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {

                         Lessonsubject=value;
                        },

                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),

                          hintText: this.Lessondocument!=null?this.Lessondocument["LessonSubject"]:'Lesson subject',
                          hintStyle: TextStyle(
                            color: const Color(0xCB101010),
                            fontSize: null,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),


                        ),
                      ),
                      SizedBox(height: 15,),

                      TextField(

                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          value!=null? stuPhoneNumber=value:stuPhoneNumber=this.Lessondocument["StuPhoneNumber"];

                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),

                          hintText: this.Lessondocument!=null?this.Lessondocument["StuPhoneNumber"]:'Student Phone Number',


                          hintStyle: TextStyle(
                            color: const Color(0xCB101010),
                            fontSize: null,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),



                        ),
                      ),
                      SizedBox(height: 15,),

                      TextField(

                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {

                          value!=null? stuName=value:stuName=this.Lessondocument["StudentName"];

                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),

                          hintText: this.Lessondocument!=null?this.Lessondocument["StudentName"]:'Student Name',


                          hintStyle: TextStyle(
                            color: const Color(0xCB101010),
                            fontSize: null,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),



                        ),
                      ),
                      SizedBox(height: 15,),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:<Widget>[
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
                                  value!=null? dateController.text=value:dateController.text=this.Lessondocument["Date"];

                                  dateController.text=value;

                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white60,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0)
                                  ),
                                  hintText: this.Lessondocument!=null?this.Lessondocument["Date"]:'Date',
                                  hintStyle: TextStyle(
                                    color: const Color(0xCB101010),
                                    fontSize: null,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 70,
                                width: 150,
                                child:TextField(
                                  textAlign: TextAlign.center,

                                  onChanged: (value) {
                                    value.isEmpty? time=this.Lessondocument["Time"]:time=value;

                                  },
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                    fillColor: Colors.white60,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),

                                    hintText: this.Lessondocument!=null?this.Lessondocument["Time"]:'Time',


                                    hintStyle: TextStyle(
                                      color: const Color(0xCB101010),
                                      fontSize: null,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),



                                  ),
                                )
                            ),

                          ]
                      ),
                      SizedBox(height:50,),

                      Center(
                       child: IconButton(icon: Icon(Icons.done,size: 50,), onPressed: (){
                        Map<String, dynamic> data;
                        if (this.Lessondocument!=null){
                         data ={"Date":dateController.text.isEmpty?this.Lessondocument["Date"]:dateController.text,"LessonSubject":Lessonsubject.isEmpty?this.Lessondocument["LessonSubject"]:Lessonsubject,"StuPhoneNumber":stuPhoneNumber.isEmpty?this.Lessondocument["StuPhoneNumber"]:stuPhoneNumber,"StudentName":stuName.isEmpty?this.Lessondocument["StudentName"]:stuName,"TeacherId":isTeacher.id,"TeacherName":this.isTeacher["FullName"],"Time":time.isEmpty?this.Lessondocument["Time"]:time};

                         editMeetingToFireStoreAsTeacher(data,this.Lessondocument.id);
                         Navigator.of(context).pushReplacement(SlideRightRoute(
                             page: Lessons(isTeacher)
                         ));

                        }else if(dateController.text.isEmpty|| Lessonsubject.isEmpty||stuPhoneNumber.isEmpty||stuName.isEmpty||time.isEmpty ) {
                          return showDialog(context: context, builder: (context) => SureDetails());

                        }else{
                          data ={"Date":dateController.text,"LessonSubject":Lessonsubject,"StuPhoneNumber":stuPhoneNumber,"StudentName":stuName,"TeacherId":isTeacher.id,"TeacherName":this.isTeacher["FullName"],"Time":time};
                          addMeetingToFireStoreAsTeacher(data);
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: Lessons(isTeacher)
                          ));
                        }






                       })
                      ),
                      SizedBox(height: 150,),
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

class SureDetails extends StatelessWidget {



  const SureDetails({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(" Must Enter All The Details !!"),




            ],
          )),
      title: Text(''),


    );
  }
}



