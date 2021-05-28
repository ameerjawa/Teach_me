
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/Sign_Up_Student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/AppManagment/Teacher_Homepage.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';


import 'Sign_Up_Teacher.dart';
import 'sign_in.dart';

// ignore: must_be_immutable
class AccountType extends StatelessWidget {

  GoogleSignIn googleSignIn;
  final auth;
  GoogleSignInAccount userObj;
  Student s;


   AccountType({Key key, this.googleSignIn,this.userObj,this.auth}) : super(key: key);


  Widget build(BuildContext context) {



    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        height:1000,
          decoration: BoxDecoration(
              color: Colors.blue.shade200
          ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),


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
              mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () async{
                          if (this.googleSignIn.currentUser!=null){
                            await this.googleSignIn.signOut();


                          }else if (this.auth.currentUser != null){

                            await auth.signOut();

                          }
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page:SignInUser()
                          ));
                        }
                    ),
                     ]),
                    Container(child: SvgPicture.asset("assets/images/bookimage.svg",allowDrawingOutsideViewBox: true,matchTextDirection: true,color: Colors.blue.shade900,height: 220,width: 350)),

                    Text(
                      'TeachMe',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Container(
                        width: 300,
                        child: Column(
                            children: <Widget>[
                              Text(
                               userObj!=null?"sign in as": 'sign up as',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                child: Text('Teacher'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white70,
                                  minimumSize: Size(100, 100),
                                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                  onPrimary: Colors.black,
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                onPressed: () async{


                                  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
                                  if (googleSignIn.currentUser ==null){
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: SignUpTeacher(userObj: userObj,auth: this.auth,)

                                    ));
                                  }else{

                                    DocumentSnapshot isTeacher = await teachers.doc("${this.userObj.id}").get();
                                    if (isTeacher.exists){
                                      Navigator.of(context).pushReplacement(SlideRightRoute(
                                          page: TeacherHomepage(isTeacher,s,"","",this.auth,this.googleSignIn)

                                      ));
                                    }else{
                                      Navigator.of(context).pushReplacement(SlideRightRoute(
                                          page: SignUpTeacher(userObj: userObj,)

                                      ));
                                    }

                                  }









                                },
                              ),

                              // ignore: deprecated_member_use
                              SizedBox(height: 20),
                              ElevatedButton(
                                child: Text('Student'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white70,
                                  onPrimary: Colors.black,
                                  minimumSize: Size(100, 100),
                                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                onPressed: () {
                                  if(userObj!=null){
                                    String email = userObj.email;
                                    String fullname=userObj.displayName;
                                    Student student= Student(email, "password", "verifyPassword", fullname, "birthDate", "phoneNumber", "location",true);
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: StudentActivity(student,googleSignIn)

                                    ));
                                  }else{
                                    Student student= Student(this.auth.currentUser.email, "password", "verifyPassword", "userObj.displayName", "birthDate", "phoneNumber", "location",true);
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: SignUpStudent(student:student)

                                    ));
                                  }

                                },
                              ),

                              // This trailing comma makes auto-formatting nicer for build methods.
                            ]
                        ),
                      ),
                    ),
                  ]
              ),
            ),

        ),
      ),
    );
  }
}
