import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'UserManagment/TeacherManagment/Teacher.dart';


Future<void> UserSetup(Map <String,dynamic> data,CollectionReference collectionReference)async{


   FirebaseAuth auth = FirebaseAuth.instance;
   String UserId = auth.currentUser.uid.toString();
   collectionReference.doc(UserId).set(data);
   return;

}

// ignore: non_constant_identifier_names






Future<void> UploadImagetofireStorage(File imageFile,String UserFullname,String UserId)async{


   final _firebaseStorage = FirebaseStorage.instance;
   var file = File(imageFile.path);

   var snapshot = await _firebaseStorage.ref()
       .child('ProfileImages/${UserFullname}${UserId}ProImage')
       .putFile(file).whenComplete(() => null);
   String downloadUrl = await snapshot.ref.getDownloadURL();
   return downloadUrl;


}



// here we connect to the database collections and retrieve the specific Teacher Data
Future<List<dynamic>> GetTeachersDetailsFromFireBase(String Subject,String Location)async{

  QuerySnapshot Teachers = await FirebaseFirestore.instance.collection(
      "Teachers").get();

  List<dynamic> TeachersDet = [];
  Teachers.docs.forEach((element) {
    if (element["Subject"] == Subject && element["Location"] == Location) {
      TeachersDet.add(element);
    }
  });

  return TeachersDet;





}


Future<List<dynamic>> GetCoursesFromFireBase(String Subject)async
{





    List<dynamic> ResultCourses =[];
    QuerySnapshot Courses = await FirebaseFirestore.instance.collection(
        "Courses").get();
    Courses.docs.forEach((element) {
      if (element["CourseSubject"] == Subject) {
        ResultCourses.add(element);
      }
    });
    return ResultCourses;


}



Future<List<dynamic>> GetExamsFromFireBase(String Subject)async{




    List<dynamic> ResultExams =[];
    QuerySnapshot Exams = await FirebaseFirestore.instance.collection(
        "Exams").get();
    Exams.docs.forEach((element) {
      if (element["ExamSubject"] == Subject) {
        ResultExams.add(element);
      }
    });
    return ResultExams;

}

Future<List<dynamic>> GetMeetingsFromFireBase(String UserID)async{




  List<dynamic> ResultMeetings =[];
  QuerySnapshot Meetings = await FirebaseFirestore.instance.collection(
      "Meetings").get();
  Exams.docs.forEach((element) {
    if (element["StudentID"] == UserID || element["TeacherID"]==UserID) {
      ResultMeetings.add(element);
    }
  });
  return ResultMeetings;

}

