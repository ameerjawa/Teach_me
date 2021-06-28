import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/StudentsScreens/CoursesScreens/Courses_in_Category_Screen.dart';
import 'package:teach_me/AppManagment/StudentsScreens/CoursesScreens/Show_Video_From_Course_Screen.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// ignore: must_be_immutable
class CourseDetailsScreen extends StatefulWidget {
  String name;
  int coursesCount;
  Student student;
  List<String> videosDuration;
  GoogleSignIn googleSignIn;
  QuerySnapshot<Map<String, dynamic>> resultCat;
  Map<String, dynamic> course;
  String categoryImage;

  CourseDetailsScreen(
      this.student,
      this.googleSignIn,
      this.name,
      this.coursesCount,
      this.resultCat,
      this.categoryImage,
      this.videosDuration,
      this.course);

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  YoutubePlayerController _controller;
  var yt = YoutubeExplode();
  var time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: MainBoxDecorationStyle,
      child: YoutubePlayerBuilder(
          onEnterFullScreen: () {},
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: lRPadding, top: 50, right: lRPadding),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 50,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    SlideRightRoute(
                                        page: CourseCategoryPage(
                                            widget.student,
                                            widget.googleSignIn,
                                            this.widget.name,
                                            this.widget.coursesCount,
                                            this.widget.categoryImage,
                                            widget.resultCat)));
                              }),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(lRPadding),
                                border: Border.all(
                                    width: 2.0, color: Colors.white60),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(this.widget.categoryImage),
                                    fit: BoxFit.fill)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      Text(
                        this.widget.course["CourseName"],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: lRPadding, right:lRPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "\$${this.widget.course["LowPrice"]} ",
                                        style: TextStyle(fontSize: 32)),
                                    TextSpan(
                                        text:
                                            "\$${this.widget.course["HighPrice"]}",
                                        style: TextStyle(
                                            color:
                                                Colors.black87.withOpacity(0.5),
                                            decoration:
                                                TextDecoration.lineThrough))
                                  ],
                                )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person),
                                SizedBox(
                                  width: 2,
                                ),
                                Text('${this.widget.course["Subscribes"]}K'),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.star_border),
                                Text("${this.widget.course["Rating"]}")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: btnColor),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Course content",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: lRPadding),
                          ),
                          SizedBox(
                            height: lRPadding,
                          ),
                          Flexible(
                              flex: 1,
                              child: this.widget.course["videoscount"] == 0
                                  ? Center(child: Text("No Video Found"))
                                  : ListView.builder(
                                      itemCount:
                                          this.widget.course["videoscount"],
                                      // shrinkWrap: true,
                                      itemBuilder: (context, position) {
                                        int number = 0;
                                        String videoId;
                                        videoId = YoutubePlayer.convertUrlToId(
                                            this.widget.course["Videos"]
                                                [position]);

                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: Colors.black26,
                                                width: 1.0,
                                              ))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${position < 9 ? number : ''}${position + 1}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 32),
                                                        ),
                                                        SizedBox(
                                                          width: lRPadding,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                "${this.widget.course["Titles"][position]}"),
                                                            Text(
                                                              this
                                                                          .widget
                                                                          .videosDuration
                                                                          .length ==
                                                                      0
                                                                  ? ""
                                                                  : this
                                                                      .widget
                                                                      .videosDuration[
                                                                          position]
                                                                      .substring(
                                                                          0, 7),
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black26),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(SlideRightRoute(
                                                                page: ShowVideoFromCourse(
                                                                    videoId,
                                                                    this
                                                                        .widget
                                                                        .course)));
                                                      },
                                                      child: Container(
                                                        width: lRPadding*2,
                                                        height: lRPadding*2,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .greenAccent
                                                                    .withOpacity(
                                                                        1)),
                                                        child: Icon(
                                                          Icons.play_arrow,
                                                          color: btnColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: Colors.black26,
                                                width: 1.0,
                                              ))),
                                              height: 10,
                                            ),
                                          ],
                                        );
                                      },
                                    ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    ));
  }
}

class CourseContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;

  const CourseContent(
      {Key key, this.number, this.duration, this.title, this.isDone = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        SizedBox(
          width: lRPadding,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "$duration mins\n",
                style: TextStyle(fontSize: 15, color: Colors.black26)),
            TextSpan(text: title),
          ]),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: lRPadding),
          width: lRPadding*2,
          height: lRPadding*2,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.greenAccent.withOpacity(isDone ? 1 : 0.5)),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
