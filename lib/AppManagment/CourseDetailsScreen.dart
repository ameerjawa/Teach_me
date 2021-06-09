import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/CoursesHomepage.dart';
import 'package:teach_me/DBManagment/Category.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/routes/pageRouter.dart';

class CourseDetailsScreen extends StatelessWidget {


  Student student;
  GoogleSignIn googleSignIn;
  Category category;

  CourseDetailsScreen(this.student,this.googleSignIn,this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Color(0xFF90CAF9),
        image: DecorationImage(


          image: AssetImage(this.category.image),
          alignment: Alignment.topRight


        )
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,top: 50,right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page:CoursesHomePage(student,googleSignIn)
                          ));

                        }

                    ),

                  ],
                ),
                SizedBox(height: 46,),

                   Text(this.category.name,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 30
                  ),),

                Row(
                  children: <Widget>[
                    Icon(
                        Icons.person
                    ),
                    SizedBox(width: 2,),
                    Text('10K'),
                    SizedBox(width: 15,),
                    Icon(Icons.star_border),
                    Text("4.5")
                  ],

                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    RichText(text: TextSpan(

                      children:[
                        TextSpan(
                            text: "\$50",
                            style: TextStyle(fontSize: 32)
                        ),
                        TextSpan(
                            text: "\$70",style: TextStyle(
                            color: Colors.black87.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough
                        )
                        )
                      ] ,

                    )),
                  ],
                )
              ],
            ),
          ),
          Expanded(child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white
            ),
            child: SingleChildScrollView(
              child: Stack(
                children:[Padding(padding: EdgeInsets.all(30),child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Course content",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                  CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                    SizedBox(height: 5,),
                    CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                    SizedBox(height: 5,),
                    CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                    SizedBox(height: 5,),
                    CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                    SizedBox(height: 5,),
                    CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                    SizedBox(height: 5,),
                    CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                    SizedBox(height: 5,),
                    CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                    SizedBox(height: 5,),
                    CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                    SizedBox(height: 5,),
                    CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                    SizedBox(height: 5,),
                    CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                    CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                    SizedBox(height: 5,),
                    CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                    SizedBox(height: 5,),
                    CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                    SizedBox(height: 5,),
                    CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                    SizedBox(height: 5,),
                    CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                  ],

                ),),


                ]
              ),
            ),
          ),),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),

              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(
                      offset: Offset(0,4),
                      blurRadius: 50,
                      color: Colors.black26
                  )]
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(14),
                    height: 56,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFEDEE),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Icon(Icons.shopping_bag_outlined),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                      child:Container(
                        alignment: Alignment.center,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                                ,color: Colors.pinkAccent
                        ),
                        child: Text(
                          "Enroll Now",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ))
                ],
              ),
            ),
          )

        ],
      ),

    ));
  }
}


class CourseContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;

  const CourseContent({Key key, this.number, this.duration, this.title,this.isDone=false}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Row(
      children:<Widget>[
        Text(number,style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 32
        ),
        ),SizedBox(width: 20,),
        RichText(text:TextSpan(
            children: [
              TextSpan(text: "$duration mins\n",style: TextStyle(
                  fontSize: 15,
                  color: Colors.black26
              )),TextSpan(text: title),

            ]
        ),),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: 20),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape:BoxShape.circle
              ,color: Colors.greenAccent.withOpacity(isDone?1:0.5)
          ),
          child: Icon(Icons.play_arrow,color: Colors.white,),
        )

      ],
    );
  }
}
