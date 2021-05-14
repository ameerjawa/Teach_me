

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/sign_in.dart';




class Teacher_Homepage extends StatefulWidget {
  @override
  _Homepage_teacherState createState() => _Homepage_teacherState();
}

class _Homepage_teacherState extends State<Teacher_Homepage> {
  bool showvalue=false;

  Widget build(BuildContext context) {
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
                         IconButton(
                            icon: const Icon(Icons.done),
                            iconSize: 50,
                            onPressed: () {},
                        ),
                          Text('name'
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


                SizedBox(height: 70,),
                Text('inquires',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
                 ),
                Center(

                  child: Container(

                    height: 240 ,
                    decoration: new BoxDecoration(
                        color: Colors.grey,
                    ),

                    child: Column(

                      children: [
                       Row(
                          children:[ for(var i =0; i<5 ; i++)
                          Icon(Icons.star, size:70, color: Colors.yellow),
                          ]),
                        SizedBox(height: 50,),
                        Text('Still have no lessons',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),),


                      ],
                    ),
                  ),
                ),
                Column(
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
                      onPressed: () { },
                      child: Text('calander',
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
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(
                            builder: (context) => sign_in()
                        ));
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
    );
  }
}
