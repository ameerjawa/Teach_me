import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:teach_me/AppManagment/StudentsScreens/ExamsScreens/Exams_Home_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

class ResultScreen extends StatefulWidget {
  int mark;

  ResultScreen(this.mark);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with  SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _anim;
  final Rainbow _rb = Rainbow(spectrum: const [
    Colors.blue,
    Colors.white,
    Colors.purple,



    Colors.orange,
    Colors.yellow,

    Colors.indigo,
    Colors.purple,
  ], rangeStart: 0.0, rangeEnd: 200.0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward()..repeat();
    _anim = bgValue.animate(_controller);

  }
  Animatable<double> bgValue = Tween<double>(begin: 0.0, end: 30.0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle: true,

        title: Text(
          "Result"
        ),

      ),
      body: Column(
        children: [

          Expanded(flex: 6,

          child: Center(

            child: Container(


                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage(

                       'assets/images/image2.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,

                ),
            ),
          ),),
          Expanded(flex:5,
            child: Container(
              alignment: Alignment.center,

              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation:_controller ,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                           // color: _rb[_anim.value],
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.lightBlue.shade400),

                            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade400),
                          ),

                        ),
                        padding: EdgeInsets.all(24.0),
                        child: Text('congratulations You  Scored ${this.widget.mark*4}/100 marks',
                        textAlign: TextAlign.center,
                        style: TextStyle( fontWeight: FontWeight.w600,fontSize: 30.0, fontFamily: 'Times New Roman',color: _rb[(_anim.value - 2) % 10]),), //shift one color backward
                      );
                    }
                )



                  // child: Text(
                  //   "congratulations You  Scored ${this.widget.mark*4}/100 marks",
                  //     textScaleFactor:1.1,
                  //   style: TextStyle(
                  //     fontFamily: 'Times New Roman',
                  //     fontSize: 30.0,
                  //     color: color,
                  //     fontWeight: FontWeight.w600
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),

                ),
              ),


            ),




          Expanded(flex:2,child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50)
            ),
            padding: EdgeInsets.only(bottom: 20),
            height: 100,
            width:220 ,
            child: MaterialButton( shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), color:Colors.white24,child: Text("ExamsHomePage",style: TextStyle(
              color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
            ),),onPressed: (){
              Navigator.pop(context);
            },),
          ),)



        ],
      ),
    );
  }
}
