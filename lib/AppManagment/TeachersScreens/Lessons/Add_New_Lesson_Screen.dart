import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Lession.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'Lessons_Screen.dart';
import 'Sure_Details_alert_add_new_Lesson.dart';

// ignore: must_be_immutable
class AddNewLesson extends StatefulWidget {
  final DocumentSnapshot document;
  Teacher teacher;
  Stream<QuerySnapshot<Map<String, dynamic>>> lessons;
  final auth;
  GoogleSignIn googleSignIn;
  var index;
  Map<String,dynamic> data;

  AddNewLesson(
      {Key key, this.teacher, this.document, this.auth, this.googleSignIn,this.lessons,this.index,this.data})
      : super(key: key);

  @override
  AddNewLessonState createState() => AddNewLessonState();
}

class AddNewLessonState extends State<AddNewLesson> {
  String lessonSubject="", stuPhoneNumber="", stuName="",stuEmail="";
  bool canGo = false;
  final dateController = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  var lessonslist=[];


  AddNewLessonState();

  @override
  void initState() {
    timeInput.text = ""; //set the initial value of text field


    super.initState();

  }



  bool checkIfSameTimeAndDateForAdd( Lesson lesson,List<dynamic> lessons){
    // lessons.first.then((value) => {
    //
    //   value.docs.forEach((element) {
    //
    // if(element["Time"] == lesson.time && element["Date"] == lesson.date ) {
    //      flag=false;
    // }
    // })
    //
    //
    //
    // });
    for (var i=0;i<lessonslist.length;i++){
      if(lessonslist[i]["Time"]==lesson.time && lessonslist[i]["Date"]==lesson.date){
        return false;
      }
    }



    return true;

  }


  Widget build(BuildContext context) {
    widget.lessons.first.then((value) => {

      value.docs.forEach((element) {

        //  if(element["Time"] == lesson.time && element["Date"] == lesson.date ) {
lessonslist.add(element.data());
        // }
      })});


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: Lessons(
                                        this.widget.teacher,
                                        this.widget.auth,
                                        this.widget.googleSignIn)));
                          }),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Image.asset("assets/images/newlogologo.jpeg",
                              matchTextDirection: true, height: 80, width: 120),
                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'Kaushan',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 70,
                ),
                Center(
                    child: Text(
                  this.widget.document != null
                      ? 'Edit Lesson'
                      : 'Add New Lesson',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Lesson information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          lessonSubject = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.widget.document != null
                              ? this.widget.document["LessonSubject"]
                              : 'Lesson subject',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          if(this.widget.document!=null){
                            value != null
                                ? stuPhoneNumber = value
                                : stuPhoneNumber =
                            this.widget.document["StuPhoneNumber"];
                          }else if (this.widget.data != null){

                            stuPhoneNumber=this.widget.data["StuPhone"];
                          }else{
                            stuPhoneNumber=value;
                          }

                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.widget.document != null
                              ? this.widget.document["StuPhoneNumber"]
                              : this.widget.data!=null?this.widget.data["StuPhone"]:'Student Phone Number',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          print(value);
                          if(this.widget.document!=null){
                          value != ""
                          ? stuName = value
                              : stuName = this.widget.document["StudentName"];
                          }else if (this.widget.data != null){
                            stuName=this.widget.data["StuName"];
                          }
                            stuName=value;



                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.widget.document != null
                              ? this.widget.document["StudentName"]
                              : this.widget.data!=null?this.widget.data["StuName"]: 'Student Name',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          print(value);
                          if(this.widget.document!=null){
                            value != ""
                                ? stuEmail = value
                                : stuEmail = this.widget.document["Email"];
                          }else if (this.widget.data!=null){
                            stuEmail=this.widget.data["StuEmail"];
                          }
                          stuEmail=value;

                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          hintText: this.widget.document != null
                              ? this.widget.document["StuEmail"]
                              : this.widget.data!=null?this.widget.data["StuEmail"]: 'Student Email',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 130,
                              child: TextField(
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
                                  if(this.widget.document!=null){
                                  value != null
                                  ? dateController.text = value
                                      : dateController.text =
                                  this.widget.document["Date"];
                                  }
                                    dateController.text=value;


                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white60,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  hintText: this.widget.document != null
                                      ? this.widget.document["Date"]
                                      : 'Date',
                                  hintStyle: InputTextStyle,
                                ),
                              ),
                            ),
                            Container(
                                height: 70,
                                width: 150,
                                child: TextField(
                                  style: TextStyle(
                                    color: const Color(0xCB101010),
                                    fontSize: InputFontSize + 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  readOnly: true,
                                  controller: timeInput,
                                  textAlign: TextAlign.center,
                                  onTap: () async {
                                    TimeOfDay pickedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      setState(() {
                                        timeInput.text = pickedTime
                                            .format(context)
                                            .toString(); //set the value of text field.
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    fillColor: Colors.white60,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0)),
                                    hintText: this.widget.document != null
                                        ? this.widget.document["Time"]
                                        : 'Time',
                                    hintStyle: InputTextStyle,
                                  ),
                                )),
                          ]),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.done,
                                size: 50,
                              ),
                              onPressed: () async{
                                Map<String, dynamic> newLessonData;
                                try {

                                  if(this.widget.data!=null){

                                    stuPhoneNumber=this.widget.data["StuPhone"];
                                    stuName=this.widget.data["StuName"];
                                    stuEmail=this.widget.data["StuEmail"];
                                  }



                                if (this.widget.document != null) {
                                    newLessonData = {
                                      "Date": dateController.text.isEmpty
                                          ? this.widget.document["Date"]
                                          : dateController.text,
                                      "LessonSubject": lessonSubject == ""
                                          ? this
                                              .widget
                                              .document["LessonSubject"]
                                          : lessonSubject,
                                      "StuPhoneNumber": stuPhoneNumber == ""
                                          ? this
                                              .widget
                                              .document["StuPhoneNumber"]
                                          : stuPhoneNumber,
                                      "StudentName": stuName == ""
                                          ? this.widget.document["StudentName"]
                                          : stuName,"StuEmail":stuEmail == ""
                                          ?this.widget.document["StuEmail"]:stuEmail,
                                      "TeacherId": this.widget.teacher.id,
                                      "TeacherName":
                                          this.widget.teacher.fullName,
                                      "Time": timeInput.text == ""
                                          ? this.widget.document["Time"]
                                          : timeInput.text
                                    };




                                      this.widget.teacher.editMeeting(
                                          newLessonData, this.widget.document.id);
                                      Navigator.of(context).pushReplacement(
                                          SlideRightRoute(
                                              page: Lessons(
                                                  this.widget.teacher,
                                                  this.widget.auth,
                                                  this.widget.googleSignIn)));






                                  } else if (dateController.text=="" ||
                                      lessonSubject.isEmpty ||
                                      stuPhoneNumber.isEmpty ||
                                      stuName.isEmpty ||
                                      timeInput.text.isEmpty) {
                                  print("ameer is here");
                                    return showDialog(
                                        context: context,
                                        builder: (context) => SureDetails(
                                            "Must Enter All The Details !!"));
                                  } else {



                                    Lesson lesson = new Lesson(
                                        dateController.text,
                                        stuName,
                                        this.widget.teacher.id,
                                        this.widget.teacher.fullName,
                                        timeInput.text,
                                        stuPhoneNumber,
                                        lessonSubject,stuEmail);


                                    print(lesson);






                                    if(checkIfSameTimeAndDateForAdd(lesson,lessonslist)){
                                      this.widget.teacher.addMeeting(lesson);
                                      Navigator.of(context).pushReplacement(
                                          SlideRightRoute(
                                              page: Lessons(
                                                  this.widget.teacher,
                                                  this.widget.auth,
                                                  this.widget.googleSignIn)));
                                   }else{
                                     return showDialog(
                                         context: context,
                                         builder: (context) => SureDetails(
                                             "Cant add this Meeting .. you have in the same date and time already"));
                                   }

                                  }
                                } catch (e) {
                                  print(
                                      "something went wrong in addnewlesson on pressed line 406 AddNewLesson_Screen $e");
                                }
                              })),
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
