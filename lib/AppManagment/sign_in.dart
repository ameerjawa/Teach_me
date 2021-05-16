import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/Teacher_Homepage.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/Userbg.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/AccountType.dart';
import 'Sign_Up_Teacher.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/sign_up_user.dart';




import 'StudentActivity.dart';


class _MyHomePageState extends State<sign_in> {
  void _incrementCounter() {
    setState(() {
    });
  }
    String email ,password ;
  CollectionReference Teachers = FirebaseFirestore.instance.collection("Teachers");



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return  Scaffold(

        body: Center(

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

                Icon(Icons.book, size: 150,color :Colors.white),
                SizedBox(height: 40),
                Text(
                  'TeachMe',
                  style: TextStyle(fontWeight: FontWeight.bold ,  fontSize: 50,color:Colors.white),
                ),
                SizedBox(height: 100),
                Center(
                  child: Container(
                      width: 300,
                      child:Column(

                          children: <Widget>[
                            TextField(
                              onChanged: (value){
                                email = value;
                              },
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
                            TextField(
                              onChanged: (value){
                                password=value;
                              },
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
                      )
                  ),
                ) ,
                SizedBox(height: 5),
                RaisedButton(
                  color: Colors.white60,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black,width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {

                    Userbg newlogin = Userbg(email,password,"","","","","");
                    newlogin.login(context, Teachers);

                  },
                  child: const Text(
                    'sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                  color: Colors.white60,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black,width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: ()async {


                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => Sign_Up_User()

                    ));

                  },
                  child: const Text(
                    'sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton( icon: const Icon(Icons.help),iconSize: 70,alignment: Alignment.topRight, onPressed: ()=>showDialog(
                      context: context,
                      builder: (context) => AboutWidget(),

                    ),

                    )

                ),
                SizedBox(height: 2),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.white60,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => Sign_Up_Teacher()
                    ));
                  },
                  child: const Text(
                    'SIGN IN WITH FACEBOOK',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.white60,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {



                 //   Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    //    builder: (context) => sign_in()

                  //  ));
                  },
                  child: const Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(fontSize: 20),
                  ),
                ),],
            ),
          ),

        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    
  }

}

class sign_in extends StatefulWidget {
  sign_in({Key key, this.title}) : super(key: key);

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