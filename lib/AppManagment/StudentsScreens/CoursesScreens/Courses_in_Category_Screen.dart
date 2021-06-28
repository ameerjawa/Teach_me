import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/StudentsScreens/CoursesScreens/Courses_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'Course_Details_Screen.dart';

// ignore: must_be_immutable
class CourseCategoryPage extends StatefulWidget {
  String name;
  int coursescount;
  QuerySnapshot<Map<String, dynamic>> catcourses;
  GoogleSignIn googleSignIn;
  Student student;
  String categoryImage = "";

  CourseCategoryPage(this.student, this.googleSignIn, this.name,
      this.coursescount, this.categoryImage, this.catcourses);

  @override
  _CourseCategoryPageState createState() => _CourseCategoryPageState();
}

class _CourseCategoryPageState extends State<CourseCategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var yt = YoutubeExplode();
  var time;
  List<String> videosDuration;

  _CourseCategoryPageState();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      videosDuration = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: EdgeInsets.only(left: lRPadding, top: lRPadding+10, right: lRPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: lRPadding+10,
                  onPressed: () async {
                    // ignore: deprecated_member_use
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      duration: new Duration(seconds: 3),
                      content: new Row(
                        children: <Widget>[
                          new CircularProgressIndicator(),
                          SizedBox(
                            width: lRPadding+10,
                          ),
                          new Text(" Moving to Courses ")
                        ],
                      ),
                    ));

                    try {
                      var resultcat = await this.widget.student.getCategories();

                      Navigator.of(context).pushReplacement(SlideRightRoute(
                          page: CoursesHomePage(this.widget.student,
                              this.widget.googleSignIn, resultcat)));
                    } catch (e) {
                      print(
                          "somthing wrong with getting the categories from firebase line 89 Corses_inCategories_screen");
                    }
                  }),
              SizedBox(
                height: lRPadding,
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
                height: lRPadding+10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Course',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: lRPadding),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: lRPadding-5),
                  )
                ],
              ),
              SizedBox(
                height: lRPadding*2.5,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    color: Colors.white60,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: this.widget.coursescount,
                    crossAxisSpacing: lRPadding,
                    mainAxisSpacing: lRPadding,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            videosDuration = [];

                            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                              duration: new Duration(seconds: 40),
                              content: new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  SizedBox(
                                    width: lRPadding+10,
                                  ),
                                  new Text(
                                      " Moving to Course ,may take more than 20 sec ")
                                ],
                              ),
                            ));

                            try {
                              List<dynamic> videos = await this
                                  .widget
                                  .catcourses
                                  .docs
                                  .elementAt(index)
                                  .data()["Videos"];

                              if (videos.length > 0) {
                                for (int i = 0; i < videos.length; i++) {
                                  if (videos[i] != "") {
                                    var video = await yt.videos.get(videos[i]);

                                    setState(() {
                                      time = video.duration;
                                      videosDuration.add(time.toString());
                                    });
                                  }
                                }
                              }

                              Navigator.of(context).pushReplacement(
                                  SlideRightRoute(
                                      page: CourseDetailsScreen(
                                          this.widget.student,
                                          this.widget.googleSignIn,
                                          this.widget.name,
                                          this.widget.coursescount,
                                          this.widget.catcourses,
                                          this.widget.categoryImage,
                                          videosDuration,
                                          this
                                              .widget
                                              .catcourses
                                              .docs
                                              .elementAt(index)
                                              .data())));
                            } catch (e) {
                              print("somthing wrong with getting the durations of the videos line 191 Courses_in_Cateegory_Screen");
                            }
                          },
                          child: Container(
                            height: index.isEven ? 190 : 230,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(lRPadding*0.5),
                                border:
                                    Border.all(width: 1.4, color: Colors.black),
                                image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.8),
                                        BlendMode.dstATop),
                                    image:
                                        NetworkImage(this.widget.categoryImage),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.all(lRPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this
                                        .widget
                                        .catcourses
                                        .docs
                                        .elementAt(index)
                                        .data()["CourseName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: lRPadding+2),
                                  ),
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
