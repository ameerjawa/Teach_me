import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class search_for_teacher_StudentActivity extends StatefulWidget {
  @override
  _SearchforTeacherState createState() => _SearchforTeacherState();
}

class _SearchforTeacherState extends State<search_for_teacher_StudentActivity> {
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 50,
                            alignment: Alignment.topLeft,
                            onPressed: () {

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
                            Icon(Icons.book, size: 110, color: Colors.black),
                             Text(
                            'TeachMe',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                            ),  ]),
                      ),
                  SizedBox(height: 70,),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        children: <Widget>[
                    TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'
                ),
              ),
                          SizedBox(height: 10,),

                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter a search term'
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text("By his/her Place",
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
                      onPressed: () {

                      }
                  ),



    ]),
      ),
    ),
    );
  }
}
