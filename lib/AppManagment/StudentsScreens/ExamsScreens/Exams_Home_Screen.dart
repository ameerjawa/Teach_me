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
          padding: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(SlideRightRoute(
                        page: StudentActivity(
                            this.widget.student, this.widget.googleSignIn)));
                  }),
              SizedBox(
                height: 20,
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
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(40)),
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
                  icon: Icon(Icons.search),
                  hintText: "Search for an Exam",

                ),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Category',
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
                      itemCount: filteredExams.length,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => SureEnterExam(
                                result: filteredExams[index],
                              ),
                            );
                          },
                          child: Container(
                            
                            height: index.isEven ? 200 : 240,
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),

                                    image: AssetImage(
                                        "assets/images/${filteredExams[index]["image"]}"),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    filteredExams[index]["ExamName"],
                                    style: TextStyle(
                                    color: Colors.black,
                                        fontFamily: 'Kaushan',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
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
