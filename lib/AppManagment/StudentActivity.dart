import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/search_for_teacher_StudentActivity.dart';
import 'package:teach_me/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';


import 'sign_in.dart';


// ignore: must_be_immutable
class StudentActivity extends StatelessWidget {
  Student student;
  GoogleSignIn googleSignIn;


  final _auth = FirebaseAuth.instance;

  StudentActivity(this.student, this.googleSignIn);


  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,
        child: Center(

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: Column(
                mainAxisAlignment:MainAxisAlignment.center,

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

                children: <Widget>[
            Container(child:Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 160,width: 250),
            ),

            Text(
              'TeachMe',
              style: TextStyle(fontSize: 45,                                fontFamily: 'Kaushan',
              ),
            ),
            SizedBox(height: 30),
            Text(student.email != null ? student.email : "your email",
            style: TextStyle(fontSize: 20, color: Colors.white)
            ),
            SizedBox(height: 10),

            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
            color: Colors.blue.shade500,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0) ,
                topRight: Radius.circular(100.0),
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(20.0)
            ),
            //  borderRadius: BorderRadius.circular(30),
              ),

              child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(ScaleRoute(
                  page: SearchForTeacherStudentActivity(
                      this.student, this.googleSignIn, this._auth)

              ));
            },

            child:
            Text("Search For Teacher",
                style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: BtnFont))
            ,
            // padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 80.0,left: 80.0),
            // shape: new RoundedRectangleBorder(
            //   borderRadius: new BorderRadius.circular(30.0),
            // ),


              ),
            )
            , SizedBox(height: 20.0)
            , Container(
          height: 100,
          width: 250,
          decoration:   BoxDecoration(
          color: Colors.blue.shade500,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0) ,
              topRight: Radius.circular(100.0),
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(20.0)
          ),
          //  borderRadius: BorderRadius.circular(30),
        ),
          child: TextButton(
            onPressed: (){},
            child:
            Text("Level Exams",
            style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: BtnFont))
            ,
            // padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 80.0,left: 80.0),
            // shape: new RoundedRectangleBorder(
            //   borderRadius: new BorderRadius.circular(30.0),
            // ),


          ),
        ), SizedBox(height: 20.0),

        Container(
          height: 100,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.blue.shade500,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0) ,
              topRight: Radius.circular(100.0),
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(20.0)
            ),
          //  borderRadius: BorderRadius.circular(30),
          ),
          child: TextButton(


            onPressed: (){

            },
            child:
            Text("Courses", style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: BtnFont))
            ,
            // padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 80.0,left: 80.0),
            // shape: new RoundedRectangleBorder(
            //   borderRadius: new BorderRadius.circular(30.0),
            // ),


          ),
        ),
        SizedBox(height: 20.0,),
        TextButton(
          onPressed: () =>
              showDialog(
            context: context,
            builder: (context) =>
                SureLogout(auth: _auth, googleSignin: googleSignIn),

              ),
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),


        ],
      ),)
    ,
    )
    ,
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

void get() async {
  // DocumentReference<Map<String, dynamic>> student = await FirebaseFirestore.instance.collection(
  //     "Students").doc(userid);
  //
  // return student;


}


// ignore: must_be_immutable
class SureLogout extends StatelessWidget {


  final auth;
  GoogleSignIn googleSignin;

  SureLogout({Key key, this.auth, this.googleSignin}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(" are U sure ?"),


              SizedBox(height: 20,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,


                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,

                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,),),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,

                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () async {
                        if (auth != null) {
                          print(auth.currentUser == null);
                          await auth.signOut();
                          print(auth.currentUser == null);


                          if (auth.currentUser == null) {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: SignInUser()

                                ));
                          }
                        } else {
                          try {

                            await this.googleSignin.signOut();


                            if (this.googleSignin.currentUser == null) {
                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: SignInUser()

                                  ));
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text('LogOut',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,),),
                    ),

                  ],
                ),
              ),


            ],
          )),
      title: Text(''),


    );
  }
}

//
// Future<void> signOutAuth() {
//
// }
//
// Future<void> signoutGoogle() {
//
// }
