import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Course.dart';



Future<void> userSetup(Map <String,dynamic> data,CollectionReference collectionReference)async{


   FirebaseAuth auth = FirebaseAuth.instance;
   String UserId = auth.currentUser.uid.toString();
   collectionReference.doc(UserId).set(data);
   return;

}

// ignore: non_constant_identifier_names






Future<void> uploadImagetofireStorage(File imageFile,String userFullName,String userId)async{


   final _firebaseStorage = FirebaseStorage.instance;
   var file = File(imageFile.path);

   var snapshot = await _firebaseStorage.ref()
       .child('ProfileImages/${userFullName}${userId}ProImage')
       .putFile(file).whenComplete(() => null);
   String downloadUrl = await snapshot.ref.getDownloadURL();
   return downloadUrl;


}



// here we connect to the database collections and retrieve the specific Teacher Data
Future<List<dynamic>> getTeachersDetailsFromFireBase(String Subject,String Location)async{

  QuerySnapshot Teachers = await FirebaseFirestore.instance.collection(
      "Teachers").get();

  List<dynamic> TeachersDet = [];
  Teachers.docs.forEach((element) {

   if (element.get(FieldPath(["subjects"])) == Subject && element.get(FieldPath(["Location"])) == Location)
    {
      TeachersDet.add(element.data());
    }
  });

  return TeachersDet;





}


Future<List<dynamic>> getCoursesFromFireBase(String Subject)async
{





    List<dynamic> ResultCourses =[];
    QuerySnapshot Courses = await FirebaseFirestore.instance.collection(
        "CoursesData").get();
    Courses.docs.forEach((element) {
      if (element.get(FieldPath(["CourseSubject"])) == Subject) {
        ResultCourses.add(element.data());
      }
    });
    return ResultCourses;


}



Future<List<dynamic>> getExamsFromFireBase(String Subject)async{




    List<dynamic> ResultExams =[];
    QuerySnapshot Exams = await FirebaseFirestore.instance.collection(
        "Exams").get();
    Exams.docs.forEach((element) {
      if (element.get(FieldPath(["ExamSubject"])) == Subject) {
        ResultExams.add(element.data());
      }
    });
    return ResultExams;

}

Future<List<dynamic>> getMeetingsFromFireBase(String userID)async{




  List<dynamic> resultMeetings =[];
  QuerySnapshot meetings = await FirebaseFirestore.instance.collection(
      "meetings").get();
  meetings.docs.forEach((element) {
    if (element.get(FieldPath(["StudentId"])) == userID || element.get(FieldPath(["TeacherId"]))==userID) {
      resultMeetings.add(element.data());
    }
  });
  return resultMeetings;

}

Future<void> addMeetingToFireStoreAsTeacher(Map <String,dynamic> data)async{
  CollectionReference meetings = await FirebaseFirestore.instance.collection("meetings");

 await meetings.add(data);

}

Future<void> editMeetingToFireStoreAsTeacher(Map <String,dynamic> data,String meetingId)async{
  CollectionReference Meetings = await FirebaseFirestore.instance.collection("meetings");

  await Meetings.doc(meetingId).update(data);

}

Future<List<dynamic>> getStudentFromFireBase(String email)async{

  List<dynamic> resultStudents =[];
  QuerySnapshot students = await FirebaseFirestore.instance.collection(
      "Students").get();
  students.docs.forEach((element) {

    if (element.get(FieldPath(["Email"]))==email) {
      resultStudents.add(element.data());
    }
  });
  return resultStudents;

}

Future<void> addCourseToFireBase(Map<String,dynamic> data)async{

  CollectionReference Courses = await FirebaseFirestore.instance.collection("CoursesData");

  await Courses.add(data);

}

Future<void> addExamToFireBase(Map<String,dynamic> data )async{

  CollectionReference exams = await FirebaseFirestore.instance.collection("Exams");

  await exams.add(data);

}