




// ignore: camel_case_types
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountType.dart';

class TeacherlessionsDetail extends StatefulWidget {
  @override
  TeacherlessionsDetails createState() => TeacherlessionsDetails();
}

class TeacherlessionsDetails extends State<TeacherlessionsDetail> {

  String email, password, verifypassword;
  bool CanGo=false;



  Widget build(BuildContext context) {
    final _auth= FirebaseAuth.instance;
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
                          Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (context) => AccountType()
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
              SizedBox(height: 10,),
              Center(
                child: Text(
                  'Lessions Information',
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
                    SizedBox(height: 15,),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {

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
                    SizedBox(height: 15,),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {

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
                    SizedBox(height: 15,),

                       Container(


                         child: TextField(

                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {

                          },
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(vertical: 75.0, horizontal: 10.0),
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
                       ),
                    Row(
                      children:<Widget>[
                        Text(
                           'Can You Go to Student House ?'
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(


                              child: Row(

                                children: [

                                  // ignore: deprecated_member_use
                                  FlatButton(onPressed: (){
                                    color: CanGo ? Colors.red : Colors.green;
                                    setState(() {
                                      CanGo=!CanGo;

                                    });



                                  }, child: Text('Can'),
                                    color: CanGo ? Colors.red : Colors.green,),


                                ],
                              )
                          ),
                        ),
                      ]

                    ),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                     children:<Widget>[
                       Container(
                         height: 70,
                         width: 150,
                         child:TextField(
                           keyboardType: TextInputType.emailAddress,
                           textAlign: TextAlign.center,
                           onChanged: (value) {

                           },
                           decoration: InputDecoration(
                             contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                             fillColor: Colors.white60,
                             filled: true,
                             border: OutlineInputBorder(
                                 borderRadius: new BorderRadius.circular(15.0)
                             ),

                             hintText: 'Price',


                             hintStyle: TextStyle(
                               color: const Color(0xCB101010),
                               fontSize: null,
                               fontWeight: FontWeight.w700,
                               fontStyle: FontStyle.normal,
                             ),



                           ),
                         )
                       ),
                       Column(
                         children: [
                           IconButton(
                               icon: const Icon(Icons.arrow_forward),
                               iconSize: 50,

                               alignment: Alignment.topLeft,
                               onPressed: () async {

                                 Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                     builder: (context) => TeacherlessionsDetail()
                                 ));

                               }
                           ),
                           Text(
                             'Next',
                             textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(fontWeight: FontWeight.bold),
                           )
                         ],
                       ),
                     ]
                   )
                  ],
                ),
              ),


            ],
          ),
        ),

      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}