import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/search_for_teacher_StudentActivity.dart';
import 'sign_in.dart';

class StudentActivity extends StatelessWidget  {
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

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

            children: <Widget>[
              SizedBox(height: 60.0,),
              Icon(Icons.book,
                size: 170.0,),
              SizedBox(height: 15.0,),
              Text(
                'TeachMe',
                style: TextStyle(fontSize: 45),
              ),
              SizedBox(height: 30),

              SizedBox(
                width: 270.0,
                child: RaisedButton(
                  child:
                  Text("Search For Teacher",    style: TextStyle(fontSize: 20,color: Colors.white)
                  ),



                  padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 40.0,left: 40.0),
                  onPressed: () {


                   Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) =>search_for_teacher_StudentActivity()

                    ));

                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),



                ),
              ),SizedBox(height: 20.0)
              ,SizedBox(
                width: 270.0,
                child: RaisedButton(

                  child:
                  Text("Level Exams",style: TextStyle(fontSize: 20,color: Colors.white))
                  ,
                  padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 40.0,left: 40.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),

                ),
              ),SizedBox(height: 20.0),SizedBox(
                width: 270.0,
                child: RaisedButton(
                  child:
                  Text("Courses",style: TextStyle(fontSize: 20,color: Colors.white))
                  ,
                  padding: EdgeInsets.only(top:40.0,bottom: 40.0,right: 80.0,left: 80.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),


                ),
              ),SizedBox(height: 20.0,),
              FlatButton(
                onPressed: () {


                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                     builder: (context) => sign_in()

                  ));

                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black,fontSize: 18.0),
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

