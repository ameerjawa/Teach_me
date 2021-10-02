import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/CoursesScreens/Courses_in_Category_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: must_be_immutable
class CoursesHomePage extends StatefulWidget {
  Student student;
  GoogleSignIn googleSignIn;
  var resultCat;

  CoursesHomePage({Key key,this.student, this.googleSignIn, this.resultCat});

  @override
  _CoursesHomePageState createState() => _CoursesHomePageState();
}

class _CoursesHomePageState extends State<CoursesHomePage> {
  String selectedCourse = "";
  List<dynamic> filteredCourses = [];

  @override
  void initState() {
    setState(() {
      filteredCourses = this.widget.resultCat;
    });
    super.initState();
  }

  _CoursesHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: EdgeInsets.only(
              left: lRPadding, top: lRPadding + 10.0, right: lRPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: lRPadding + 10,
                  onPressed: () {
                    // moving to StudentActivity
                    Navigator.of(context).pushReplacement(SlideRightRoute(
                        page: StudentActivity(
                            student:this.widget.student, googleSignIn:this.widget.googleSignIn)));
                  }),
              SizedBox(
                height: lRPadding,
              ),
              Text(
                'Hey ${this.widget.student.fullName}',
                style: InputTextStyle,
              ),
              Text(
                'Find a Course You want to Learn',
                style: InputTextStyle,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: lRPadding),
                  height: lRPadding * 3,
                  padding: EdgeInsets.symmetric(
                      horizontal: lRPadding, vertical: lRPadding - 8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(lRPadding * 2)),
                  child: TextField(
                    maxLines: 1,
                    onChanged: (value) {
                      value = value.toLowerCase();

                      setState(() {
                        filteredCourses =
                            this.widget.resultCat.where((element) {
                          String categoryName = element["name"].toLowerCase();
                          return categoryName.contains(value);
                        }).toList();
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                        hintText: "Search for any Course",
                        hintStyle: TextStyle(fontWeight: FontWeight.w700)),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: lRPadding),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: lRPadding - 5.0),
                  )
                ],
              ),
              SizedBox(
                height: lRPadding * 2.5,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(lRPadding * 0.5),
                        topRight: Radius.circular(lRPadding * 0.5)),
                    border: Border.all(width: 1.0, color: Colors.white)),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: filteredCourses.length,
                    crossAxisSpacing: lRPadding,
                    mainAxisSpacing: lRPadding,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            String categoryName =
                                this.widget.resultCat[index]["name"];

                            // function that get name of categories and return all the Courses There
                            try {
                              QuerySnapshot<Map<String, dynamic>> catCourses =
                                  await this
                                      .widget
                                      .student
                                      .getCategoryCourses(categoryName);
                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: CourseCategoryPage(
                                          this.widget.student,
                                          this.widget.googleSignIn,
                                          filteredCourses[index]["name"],
                                          this.widget.resultCat[index]
                                              ["Courses"],
                                          this.widget.resultCat[index]
                                              ["categoryImage"],
                                          catCourses)));
                            } catch (e) {
                              print(
                                  "somthing wrong with getting the categories from firebase");
                            }
                          },
                          child: Container(
                            height:
                                index.isEven ? lRPadding * 10 : lRPadding * 12,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(lRPadding * 0.5),
                                border:
                                    Border.all(width: 1.4, color: Colors.black),
                                image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.7),
                                        BlendMode.dstATop),
                                    image: NetworkImage(this
                                        .widget
                                        .resultCat[index]["categoryImage"]),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.all(lRPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    filteredCourses[index]["name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: lRPadding),
                                  ),
                                  Text(
                                    "${filteredCourses[index]["Courses"]} Courses",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
