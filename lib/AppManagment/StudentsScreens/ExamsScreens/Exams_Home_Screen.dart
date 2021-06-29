import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';

import '../Student_Activity_Home_Screen.dart';
import 'Sure_Enter_Exam_Widget.dart';

// ignore: must_be_immutable
class ExamsHomeScreen extends StatefulWidget {
  Student student;
  GoogleSignIn googleSignIn;
  List<dynamic> result;

  ExamsHomeScreen(this.student, this.googleSignIn, this.result);

  @override
  _ExamsHomeScreenState createState() => _ExamsHomeScreenState();
}

class _ExamsHomeScreenState extends State<ExamsHomeScreen> {



  List<dynamic> filteredExams=[];

  @override

  void initState(){
    setState(() {
      filteredExams=this.widget.result[0];
    });
   super.initState();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {
                    Navigator.of(context).pushReplacement(SlideRightRoute(
                        page: StudentActivity(
                            this.widget.student, this.widget.googleSignIn)));
                  }),
              SizedBox(
                height: lRPadding,
              ),
              Text(
                'Hey ${this.widget.student.fullName}',
                style: InputTextStyle,
              ),
              Text(
                'Find an Exam to check you level',
                style: InputTextStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: lRPadding),
                height: lRPadding*3,
                padding: EdgeInsets.symmetric(horizontal: lRPadding, vertical: lRPadding-8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(lRPadding*2)),
                child: TextField(maxLines: 1,onChanged: (value){
                  value=value.toLowerCase();
                  setState(() {
                    filteredExams = this.widget.result[0].where((element) {
                      String examname= element["ExamName"].toLowerCase();
                      return examname.contains(value);
                    }
                    ).toList();

                  });


                },decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "Search for an Exam",
                    hintStyle:TextStyle(
                        fontWeight: FontWeight.w700
                    )

                ),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Category',
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
                      border:Border.all(color: Colors.white,width: 2.0),
                      color: Colors.white60,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(lRPadding * 0.5),
                        topRight: Radius.circular(lRPadding * 0.5))),
                    child: StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: filteredExams.length,
                        crossAxisSpacing: lRPadding,
                        mainAxisSpacing: lRPadding,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => SureEnterExam(
                                    result: filteredExams[index],
                                  ),
                                );
                              },
                              child: Container(

                                height: index.isEven ? 190 : 230,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.4,color:Colors.black),

                                    borderRadius: BorderRadius.circular(lRPadding*0.5),
                                    image: DecorationImage(
                                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),

                                        image: AssetImage(
                                            "assets/images/${filteredExams[index]["image"]}"),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding: const EdgeInsets.all(lRPadding),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        filteredExams[index]["ExamName"],
                                        style: TextStyle(
                                        color: Colors.black,
                                            fontFamily: 'Kaushan',
                                            fontWeight: FontWeight.bold,
                                            fontSize: lRPadding*1.5),
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
