import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/StudentsScreens/ExamsScreens/Result_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

class GetJson extends StatelessWidget {
  Map<String, dynamic> result;

  GetJson(this.result);

  @override
  Widget build(BuildContext context) {
    return result == null
        ? Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          )
        : quizpage(result);
  }
}

class quizpage extends StatefulWidget {
  Map<String, dynamic> result;

  quizpage(this.result);

  @override
  _quizpageState createState() => _quizpageState();
}

class _quizpageState extends State<quizpage> {

  Color colortoshow=Colors.indigoAccent;
  Color right=Colors.green;
  Color wrong=Colors.red;
  int marks=0;
  int i=0;
  int timer=30;
  String showTimer="30";
  bool canceltimer=false;


  @override
  void initState(){
    starttimer();
    super.initState();
  }



  void starttimer()async{
    const onesecond=Duration(seconds: 1);
    Timer.periodic(onesecond, (Timer t) {
      if(mounted) {
        setState(() {
          if (timer < 1) {
            t.cancel();
            nextQuestion();
          } else if (canceltimer) {
            t.cancel();
          } else {
            timer -= 1;
          }
          showTimer = timer.toString();
        });
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void nextQuestion(){
    canceltimer=false;
    timer=30;

    print(i);

    setState(() {
      if(i<4){
        i++;
      }else{
        Navigator.of(context).pushReplacement(ScaleRoute(page: ResultScreen(marks)));

      }

      print(i);
      for(int j=0;j<btncolor.length;j++){
        btncolor[j]=Colors.indigoAccent;
      }

      starttimer();

    });


  }


  Widget choiseButton(int k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () =>checkresult(k,i),
        child: Text(
          this.widget.result["answers"][i.toString()][k],
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        color: btncolor[k],
        splashColor: Colors.indigoAccent[700],
        highlightColor: Colors.indigoAccent[700],
        minWidth: 200.0,
        height: 45.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("TeachMe"),
                  content: Text("You Can't Go Back From This Stage"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"))
                  ],
                ));
      },
      child: Scaffold(
          body: Column(
        children: <Widget>[
          //   Text(
          //   this.widget.result["Questions"][0]
          // )
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, bottom: 40.0),
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                child: Text(
                  this.widget.result["Questions"][i],
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 24.0,
                      color: Colors.black),
                ),
                decoration: BoxDecoration(color: Colors.white),
              )),
          Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choiseButton(0),
                    choiseButton(1),
                    choiseButton(2),
                    choiseButton(3)
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman'),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.white70),
              ))
        ],
      )),
    );
  }

 void checkresult(int k,int i) {

    if (this.widget.result["answers"][i.toString()][k]==this.widget.result["correctAnswers"][i]){

      marks+=5;
      colortoshow=right;
    }else{
      colortoshow=wrong;
    }

    setState(() {

      canceltimer=true;
      btncolor[k]=colortoshow;
    });
    
    Timer(Duration(seconds: 2), nextQuestion);

  }
  Map<int,Color> btncolor={
    0:Colors.indigoAccent,
    1:Colors.indigoAccent,
    2:Colors.indigoAccent,
    3:Colors.indigoAccent,
  };





}
