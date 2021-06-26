


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/DBManagment/TeacherAccountManagment/Teacher_FireBase_Service.dart';
import 'package:teach_me/DBManagment/UserAccountManagment/User_FireBase_Service.dart';

import 'file:///D:/ameer/teach_me/lib/UserManagment/TeacherManagment/TeacherProfiles.dart';

import '../../DBManagment/FireBase_Service.dart';
import '../Userbg.dart';

class Student extends Userbg implements TeacherProfiles{

  final bool isMale;
  int grade;

  Student(String email, String password, String verifyPassword, String fullName, String birthDate, String phoneNumber, String location, this.isMale) : super(email, password, verifyPassword, fullName, birthDate, phoneNumber, location);





  // static function that we use in signin page to get the student when succesful signin 

  static Future<Student>  getStudentByIdFromFireBase(String id)async{
    CollectionReference students = FirebaseFirestore.instance.collection("Students");
    DocumentSnapshot studentSnapShot= await students.doc(id).get();

    String fullName= studentSnapShot.get(FieldPath(["FullName"]));
    String location= studentSnapShot.get(FieldPath(["Location"]));
    String phoneNumber= studentSnapShot.get(FieldPath(["PhoneNumber"]));
    String birthDate= studentSnapShot.get(FieldPath(["BirthDate"]));
    String email= studentSnapShot.get(FieldPath(["Email"]));


    Student student=new Student(email, "", "", fullName, birthDate, phoneNumber, location, false);

    return student;


  }




  void signUpASStudent(Student student,CollectionReference collectionReference,String userId)async{
     var isTeacher=false;


    Map <String,dynamic> data = {"Email":student.email,"FullName":student.fullName,"PhoneNumber":student.phoneNumber,"UserType":isTeacher,"Location":student.location,"BirthDate":student.birthDate,"grade":student.grade,"ismale":student.isMale.toString()} ;


    await userSetup(data,collectionReference,userId);
  }



  //------------------------
  // Search for Teacher
 // Future<List<Teacher>> getTeacherDetails(String subject, String location) async  {
 //
 //
 //    // return  await getTeachersDetailsFromFireBase(subject, location);
 //  //
 //
 //
 //  }





//----------------
  // Search for courses
  Future<List<dynamic>> searchForCourses(String subject) async {


    return await getCoursesFromFireBase(subject);

  }

  Future<List<dynamic>> searchForMeetings(String userID) async {


    return await getMeetingsFromFireBase(userID);

  }
  Future<List<dynamic>> searchForExams(String subject) async {


    return await getExamsFromFireBase();

  }




  Future<List<dynamic>> getCategories() async{


    return await getCategoriesFromFireBase();
  }






}
