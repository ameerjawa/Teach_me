import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/CourseDetailsScreen.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/Constants/constants.dart';
import 'package:teach_me/DBManagment/Category.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teach_me/routes/pageRouter.dart';

class CoursesHomePage extends StatefulWidget {
  Student student;
  GoogleSignIn googleSignIn;


  CoursesHomePage(this.student,this.googleSignIn);
  @override
  _coursesHomePageState createState() => _coursesHomePageState(student,googleSignIn);
}

class _coursesHomePageState extends State<CoursesHomePage> {
  Student student;
  GoogleSignIn googleSignIn;


  _coursesHomePageState(this.student,this.googleSignIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: EdgeInsets.only(left: 20,top: 30,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(SlideRightRoute(

                      page: StudentActivity(student,this.googleSignIn)
                    ));

                  }

              ),
              SizedBox(height: 20,),
              Text(
                'Hey ${student.fullName}',
                style: InputTextStyle,
              ),
              Text(
                'Find a Course You want to Learn'
                ,style: InputTextStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search
                    ),
                    SizedBox(width: 20,),
                    Text("Search for any Course",)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Category',style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  Text('See All',style: TextStyle(
                  fontSize:15
                  ),)
                ],
              )
              ,SizedBox(height: 50,),
              Expanded(child: StaggeredGridView.countBuilder(crossAxisCount: 2,itemCount: categories.length,crossAxisSpacing: 20,mainAxisSpacing: 20, itemBuilder: (context,index){

                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(SlideRightRoute(

                        page: CourseDetailsScreen(student,googleSignIn,categories[index])
                    ));
                  },
                  child: Container(

                    height: index.isEven?200:240,


                    decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(categories[index].image),
                        fit: BoxFit.fill
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(categories[index].name,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20

                          ),),
                          Text("${categories[index].numofCourses} Courses",style: TextStyle(
                            fontWeight: FontWeight.w600,color: Colors.black87
                          ),)


                        ],
                      ),
                    ),
                  ),
                );
              }, staggeredTileBuilder: (index)=>StaggeredTile.fit(1)))
            ],

          ),
        ),
      ),
    );
  }
}
