import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/CoursesScreens/Courses_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Course_Details_Screen.dart';

// ignore: must_be_immutable
class CourseCategoryPage extends StatefulWidget {
  String name;
  int coursescount;
  QuerySnapshot<Map<String, dynamic>> catcourses;
  GoogleSignIn googleSignIn;
  Student student;
  String categoryImage="";

  CourseCategoryPage(this.student, this.googleSignIn, this.name,
      this.coursescount,this.categoryImage, this.catcourses);

  @override
  _CourseCategoryPageState createState() => _CourseCategoryPageState(
    );
}

class _CourseCategoryPageState extends State<CourseCategoryPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _CourseCategoryPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  onPressed: () async {
                    // ignore: deprecated_member_use
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      duration: new Duration(seconds: 3),
                      content: new Row(
                        children: <Widget>[
                          new CircularProgressIndicator(),
                          SizedBox(
                            width: 30,
                          ),
                          new Text(" Moving to Courses ")
                        ],
                      ),
                    ));

                    var resultcat = await this.widget.student.getCategories();

                    Navigator.of(context).pushReplacement(SlideRightRoute(
                        page: CoursesHomePage(
                            this.widget.student, this.widget.googleSignIn, resultcat)));
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hey ${this.widget.student.fullName}',
                style: InputTextStyle,
              ),
              Text(
                'Here you can find ${this.widget.name} Courses that can help you with study',
                style: InputTextStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Course',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                  child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: this.widget.coursescount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: CourseDetailsScreen(
                                        this.widget.student,
                                        this.widget.googleSignIn,
                                        this.widget.name,
                                        this.widget.coursescount,
                                        this.widget.catcourses,
                                        this.widget.categoryImage,
                                        this
                                            .widget.catcourses
                                            .docs
                                            .elementAt(index)
                                            .data())));
                          },
                          child: Container(
                            height: index.isEven ? 200 : 240,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        this.widget.categoryImage),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this.widget.catcourses
                                        .docs
                                        .elementAt(index)
                                        .data()["CourseName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1)))
            ],
          ),
        ),
      ),
    );
  }
}
