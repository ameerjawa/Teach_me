import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/AppManagment/search_for_teacher_viewTeachers.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/routes/pageRouter.dart';





class search_for_teacher_StudentActivity extends StatefulWidget {
  Student student;

  search_for_teacher_StudentActivity(this.student);
  @override
  _SearchforTeacherState createState() => _SearchforTeacherState(student);
}

class _SearchforTeacherState extends State<search_for_teacher_StudentActivity> {
  bool showvalue=false;
  var controler = new TextEditingController();
  var controlersecond =new TextEditingController();
  List subjects = ["all","English","Math","maba","biology","physic","Hebrew","arabic"];
  List Locations = ["all","Haifa","TelAviv","faradis","BatYam"];
  static String selectedSubject;
  String _selectedLocation;

  Student student;

  _SearchforTeacherState(this.student);

  Widget build(BuildContext context) {
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
                    SizedBox(height: 25,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 50,
                              alignment: Alignment.topLeft,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(SlideRightRoute(
                                   page: StudentActivity(this.student)

                                ));

                              }
                          ),

                          Container(child: Row())
                              ],
                            ),

                              Center(
                              child: Column(
                              children: [
                               SizedBox(
                              height: 11,
                               ),
                              Icon(Icons.book, size: 140, color: Colors.black),
                               Text(
                              'TeachMe',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                              ),  ]),
                        ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Subject",style:TextStyle(color:Colors.black,fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Autocomplete(
                              optionsBuilder: (TextEditingValue value) {
                                // When the field is empty
                                if (value.text.isEmpty) {
                                  return [];
                                }

                                // The logic to find out which ones should appear
                                return subjects.where((suggestion) => suggestion
                                    .toLowerCase()
                                    .startsWith(value.text.toLowerCase()));
                              },
                              onSelected: (value) {
                                setState(() {
                                  selectedSubject = value;
                                });
                              },
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                "City",style:TextStyle(color:Colors.black,fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Container(
                              child: Autocomplete(
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
                                    _selectedLocation = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          //  Text(_selectedAnimal != null
                            //    ? _selectedAnimal
                              //  : 'Type something (a, b, c, etc)'),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text("By Your Place",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),



                          ),
                          Checkbox(
                            value: this.showvalue,
                            onChanged: (bool value) {
                              setState(() {
                                this.showvalue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),

                    IconButton(
                        icon: const Icon(Icons.done),
                        iconSize: 50,
                        alignment: Alignment.bottomCenter,
                        onPressed: () async{


                           //  //List<Teacher> TeachersList= await student.getTeacherDetails(selectedSubject, _selectedLocation);
                           //
                           //  print(TeachersList.first.fullName);
                           //
                           // if(TeachersList==null){
                           //   print("here ------------> Nulll");
                           // }
                           // else{
                           //   print("here -----------> NOT NULL");
                           // }

                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: search_for_teacher_viewTeachers(selectedSubject:selectedSubject,selectedLocation: _selectedLocation,s: student,)

                          ));
                        }
                    ),



    ]),
        ),
    ),
      ),
    );
  }
}
