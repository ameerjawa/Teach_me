import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




import 'StudentActivity.dart';




class SearchForTeacher extends StatelessWidget  {
  final _formKey = GlobalKey<FormState>();
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
              SizedBox(height: 30.0,),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){


                            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                builder: (context) => StudentActivity()

                            ));
                          }),
                    ],
                  )),

              Icon(Icons.book,
                size: 170.0,),
              SizedBox(height: 15.0,),
              Text(
                'TeachMe',
                style: TextStyle(fontSize: 45),
              ),
              SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(


                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.menu_book_outlined),
                          hintText: 'Enter a Subject',
                          labelText: 'Subject',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),SizedBox(height: 20.0,)
                      , TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Enter your location',
                          labelText: 'location',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.0,),


                      Positioned(
                          top: 10,
                          right: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.check_circle_outline),
                                  onPressed: (){


                                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                        builder: (context) => StudentActivity()

                                    ));
                                  }),
                            ],
                          )),

                      // Add TextFormFields and ElevatedButton here.
                    ],
                  ),

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