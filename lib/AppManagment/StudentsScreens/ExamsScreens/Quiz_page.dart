import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/StudentsScreens/ExamsScreens/Result_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: must_be_immutable
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
        : QuizPage(result);
  }
}

// ignore: must_be_immutable
class QuizPage extends StatefulWidget {
  Map<String, dynamic> result;

  QuizPage(this.result);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 0;
  int timer = 30;
  String showTimer = "30";
  bool canceltimer = false;
  Map<int, Color> btncolor = {
    0: Colors.indigoAccent,
    1: Colors.indigoAccent,
    2: Colors.indigoAccent,
    3: Colors.indigoAccent,
  };

  @override
  void initState() {
    _starttimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget choiseButton(int k) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: lRPadding * 0.5, horizontal: lRPadding),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(lRPadding)),
        onPressed: () => _checkresult(k, i),
        child: Text(
          this.widget.result["answers"][i.toString()][k],
          style: TextStyle(color: Colors.white, fontSize: lRPadding - 4),
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
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 10.0,
                  left: 10.0,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: lRPadding, bottom: lRPadding),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    this.widget.result["Questions"][i],
                    style: TextStyle(
                        fontFamily: 'Kaushan',
                        fontSize: lRPadding + 4,
                        color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1.0),
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(lRPadding * 0.5),
                          topRight: Radius.circular(lRPadding * 0.5))),
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: btnColor),
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
                        fontSize: lRPadding * 1.5,
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

  /*
  *
  * ---> all the logic in the Exam System down below
  *
  */

  // function that check result and update values in the variables
  void _checkresult(int k, int i) {
    if (this.widget.result["answers"][i.toString()][k] ==
        this.widget.result["correctAnswers"][i]) {
      marks += 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }

    setState(() {
      canceltimer = true;
      btncolor[k] = colortoshow;
    });

    Timer(Duration(seconds: 2), _nextQuestion);
  }

// function that manage the timer in bottom of the Screen of questionpage
  void _starttimer() async {
    const onesecond = Duration(seconds: 1);
    Timer.periodic(onesecond, (Timer t) {
      if (mounted) {
        setState(() {
          if (timer < 1) {
            t.cancel();
            _nextQuestion();
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

  // function that take us to the nextQuestion

  void _nextQuestion() {
    canceltimer = false;
    timer = 30;

    print(i);

    setState(() {
      if (i < 4) {
        i++;
      } else {
        Navigator.of(context)
            .pushReplacement(ScaleRoute(page: ResultScreen(marks)));
      }

      for (int j = 0; j < btncolor.length; j++) {
        btncolor[j] = Colors.indigoAccent;
      }

      _starttimer();
    });
  }
}
