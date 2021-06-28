

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ShowVideoFromCourse extends StatefulWidget {
  String videoId;
  Map<String, dynamic> course;

  ShowVideoFromCourse(this.videoId,this.course);
  @override
  _ShowVideoFromCourseState createState() => _ShowVideoFromCourseState();
}

class _ShowVideoFromCourseState extends State<ShowVideoFromCourse> {


  @override
  Widget build(BuildContext context) {


   YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: this.widget.videoId,
      flags: YoutubePlayerFlags(
          autoPlay :false
      ),
    );
return YoutubePlayerBuilder(player: YoutubePlayer(controller: _controller,), builder: (context,player){
    return Scaffold(
      body:  Container(
       
        width: double.infinity,
        child:
           Center(child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               TextButton(onPressed: (){
                 Navigator.pop(context);
               }, child: Text("BACK",style: TextStyle(
                 fontFamily: BtnFont,
                 fontSize: lRPadding+10,
                 color: Colors.black,
                 fontWeight: FontWeight.bold
               ),)),
               SizedBox(height: lRPadding,),
               player
             ],

           ))

      )
    );});
  }
}
