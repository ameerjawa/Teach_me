import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/DBManagment/CoursesManagment/Course_FireBase_Service.dart';
import 'package:teach_me/DBManagment/ExamsManagment/Exam_FireBase_Service.dart';
import 'package:teach_me/DBManagment/StudentsAccountManagment/Student_FireBase_Service.dart';
import 'package:teach_me/DBManagment/TeacherAccountManagment/Teacher_FireBase_Service.dart';
import 'package:teach_me/DBManagment/UserAccountManagment/User_FireBase_Service.dart';

import 'file:///D:/ameer/teach_me/lib/UserManagment/TeacherManagment/TeacherProfiles.dart';

import '../User/Userbg.dart';

class Student extends Userbg implements TeacherProfiles{

  final bool isMale;
  int grade;

  Student(String email, String password, String verifyPassword, String fullName, String birthDate, String phoneNumber, String location, this.isMale) : super(email, password, verifyPassword, fullName, birthDate, phoneNumber, location);




  // function that get name of catigories and return all the Courses There {from Course_FireBase_Service}
  Future<QuerySnapshot<Map<String, dynamic>>> getCategoryCourses(String name)async{

    return   getCategoryCoursesFromFireBase(name);
  }


  // function that get all the exams from the firebase {from Exam_FireBase_Service}
  Future<List<dynamic>> getExams()async{

    return await getExamsFromFireBase();

  }

  // static function that we use in signin page to get the student when succesful signin{from Student_FireBase_Service}
  static Future<Student>  getStudentById(String id)async{
   return getStudentByIdFromFireBase(id);

  }




  // function that do sign up as Student {from User_FireBase_Service}
  void signUpASStudent(Student student,CollectionReference collectionReference,String userId)async{
     var isTeacher=false;
    Map <String,dynamic> data = {"Email":student.email,"FullName":student.fullName,"PhoneNumber":student.phoneNumber,"UserType":isTeacher,"Location":student.location,"BirthDate":student.birthDate,"ismale":student.isMale.toString()} ;
    // from { User_FireBase_Service}
    await userSetup(data,collectionReference,userId);
  }



  // get categories from firebase {from Course_FireBase_Service}
  Future<List<dynamic>> getCategories() async{


    return await getCategoriesFromFireBase();
  }



  //  function that does not used yet here we can get spiciefic user all meetings by userId{from Meeting_FireBase_Service}
  Future<List<dynamic>> searchForMeetings(String userID) async {


    return await getMeetingsFromFireBase(userID);

  }

  // function that get the Teachers by Subject and location


  Stream<QuerySnapshot<Map<String, dynamic>>> getTeachers(String subject,String location,bool showValue){

     return getTeachersFromFireBaseBySubjectAndLocation(subject,location,showValue);
   }





}
