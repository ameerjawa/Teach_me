import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/AppManagment/Teacher_Homepage.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/sign_up_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';







import 'StudentActivity.dart';

class SignInUser extends StatefulWidget {
  SignInUser({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInUser> {

    String email ,password ;
  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
  CollectionReference students = FirebaseFirestore.instance.collection("Students");
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;


  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount _userObj;
  bool isLoggedin=false;

 Future<bool> _login ()async{
    try{
      _userObj=  await _googleSignIn.signIn();
      setState(() {
         isLoggedin=true;

      });
      print("hereeeee ${_userObj.displayName}");
      return isLoggedin;
    }catch(e){
      print(e);

    }
    return null;
  }


//  _logout()async{
//   try{
//     await _googleSignIn.signOut();
//     setState(() {
//       isLoggedin=false;
//     });
//
//   }catch(e){
//     print(e);
//
//   }
//
// }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return  Scaffold(

        body:Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade200
          ),
          child: Center(

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

                  // Container(child: Icon(FontAwesomeIcons.swatchbook, size: 30,color :Colors.white)),
                  Container(child: SvgPicture.asset("assets/images/bookimage.svg",allowDrawingOutsideViewBox: true,matchTextDirection: true,color: Colors.blue.shade900,height: 250,width: 400)),

                  Text(
                    'TeachMe',
                    style: TextStyle(fontWeight: FontWeight.bold ,  fontSize: 50,color:Colors.white),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Container(
                        width: 300,
                        child:Form(
                          key: _formKey,
                          child: Column(

                              children: <Widget>[
                                TextFormField(
                                  onChanged: (value){
                                    email = value;
                                  },
                                  validator:(value){
                                    if(value.isEmpty|| value==null){
                                      return "Must Type Email";
                                    }
                                    return null;
                                  } ,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white60, filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),

                                    hintText: 'Enter your email' ,
                                    hintStyle: TextStyle(
                                      color: const Color(0xCB101010),
                                      fontSize: null,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),


                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                    validator:(value){
                                      if(value.isEmpty|| value==null){
                                        return "Must Type Password";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                    password=value;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,

                                  decoration: InputDecoration(
                                    fillColor: Colors.white60, filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(
                                      color: const Color(0xCB101010),
                                      fontSize: null,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),


                                  ),
                                ),
                              ]
                          ),
                        )
                    ),
                  ) ,
                  SizedBox(height: 5),
                  ElevatedButton(
                    // color: Colors.white60,
                    // textColor: Colors.black,
                    // shape: RoundedRectangleBorder(
                    //   side: BorderSide(color: Colors.black,width: 1.8),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white60),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        color: Colors.blue
                      ))


                    ),
                    onPressed: () async {

                     // Userbg newlogin = Userbg(email,password,"","","","","");
                    // final userCredential= newlogin.login(context, Teachers);

                      if (_formKey.currentState.validate()) {
                        // TODO submit

                        try {
                          final  userCredential = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,

                          );

                          if(userCredential != null){
                            DocumentSnapshot isTeacher = await teachers.doc("${userCredential.user.uid}").get();
                            if(isTeacher.exists){

                              Student s;
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => TeacherHomepage(isTeacher,s,"","",auth,this._googleSignIn)
                              ));
                            }else{
                              DocumentSnapshot student = await students.doc("${userCredential.user.uid}").get();

                              String fullName= student.get(FieldPath(["FullName"]));
                              String location= student.get(FieldPath(["Location"]));
                              String phoneNumber= student.get(FieldPath(["PhoneNumber"]));
                             // String grade= student.get(FieldPath(["grade"]));
                              String birthDate= student.get(FieldPath(["BirthDate"]));


                              Student s = new Student("email", "password", "verifyPassword", fullName, birthDate, phoneNumber, location, true);
                              print("isStudent");
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => StudentActivity(s,_googleSignIn)
                              ));

                            }
                          }

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      }



                      }


  ,
                    child: const Text(
                      'sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  SizedBox(height: 16),
                  // Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: IconButton( icon: const Icon(Icons.help),iconSize: 70,alignment: Alignment.topRight, onPressed: ()=>showDialog(
                  //       context: context,
                  //       builder: (context) => AboutWidget(),
                  //
                  //     ),
                  //
                  //     )
                  //
                  // ),
                  Text("OR",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))

                    ),
                    child: IconButton(
                      color: Colors.black,
                    icon:Icon( FontAwesomeIcons.google),
                      onPressed: () async {

                        bool isLogedin=  await   _login();
                        if (isLogedin == true)
                        {
                          print(_userObj.id);
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: AccountType(googleSignIn: _googleSignIn,userObj: _userObj,)
                          ));
                        }

                      },
                    ),
                  ),
                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have no Account ?"),
                      TextButton(onPressed: ()async {


                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: Sign_Up_User()
                        ));

                      } , child:Text(
                        'sign up',
                        style: TextStyle(fontSize: 20,  decoration: TextDecoration.underline,),
                      ), ),

                    ],
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

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new Text("Alert Dialog body this is our app jfvkdvs"
          "dsdsdcsdcsdsvsv"),
      title: Text('data'),

    );
  }
}