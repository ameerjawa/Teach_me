
import 'dart:html';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/UserManagment/TeacherProfiles.dart';

import '../../firebase.dart';
import '../User.dart';

class Student extends User implements TeacherProfiles{

  final bool isMale;
  int grade;

  Student(String Email, String Password, String VerifyPassword, String FullName, String BirthDate, String PhoneNumber, String Location, this.isMale) : super(Email, Password, VerifyPassword, FullName, BirthDate, PhoneNumber, Location);







  void SignUpAS_Student(Map <String,dynamic> data,CollectionReference collectionReference)async{
    await UserSetup(data,collectionReference);
  }



  //------------------------
  // Search for Teacher
  @override
 Future<List<dynamic>> GetTeacherDetails(String Subject, String Location) async {


    return await GetTeachersDetailsFromFireBase(Subject, Location);

  }


//----------------
  // Search for courses
  Future<List<dynamic>> SearchForCourses(String Subject) async {


    return await GetCoursesFromFireBase(Subject);

  }

  Future<List<dynamic>> SearchForMeetings(String UserID) async {


    return await GetMeetingsFromFireBase(UserID);

  }
  Future<List<dynamic>> SearchForExams(String Subject) async {


    return await GetExamsFromFireBase(Subject);

  }






}
