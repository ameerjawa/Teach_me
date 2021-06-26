import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';




// ignore: non_constant_identifier_names








Future<String> getProfileImageFromFireBase()async{

  String url = (await FirebaseStorage.instance.ref().child("abdallaProImage").getDownloadURL()).toString();
  return url;
}



// here we connect to the database collections and retrieve the specific Teacher Data
// Stream<List<Teacher>> getTeachersDetailsFromFireBase(String Subject,String Location){
// // try {
//   Stream<QuerySnapshot<Map<String, dynamic>>> Teachers =  FirebaseFirestore.instance.collection(
//       "Teachers").where("Location" ,isEqualTo: Location);
// //   List<Teacher> TeachersDet = [];
// //
// //   Teachers.forEach((element) {
// //     element.docs.asMap().
// //     if (element.get(FieldPath(["subjects"])) == Subject &&
// //         element.get(FieldPath(["Location"])) == Location) {
// //       Teacher teacher = new Teacher(element.get(FieldPath(["email"])), "password"," verifyPassword", element.get(FieldPath(["FullName"])), element.get(FieldPath(["BirthDate"])), element.get(FieldPath(["PhoneNumber"])), element.get(FieldPath(["Location"])), element.get(FieldPath(["subjects"])), element.get(FieldPath(["More"])));
// //
// //        TeachersDet.add(teacher);
// //     }
// //   });
// // if (TeachersDet!=null)
// //      return TeachersDet;
// // } catch(e){
// //   print (e);
// //   }
//
//
//
//
//
// }

/************
 *
 * get categories from firebase
 *
 * ******/

Future<List<Map<String,dynamic>>> getCategoriesFromFireBase() async{


  QuerySnapshot<dynamic> d= await FirebaseFirestore.instance.collection('CoursesData').get();
  List<String> categories=[];
  List<Map<String,dynamic>> categoriesList=[];

  d.docs.forEach((element) {
    categories.add(element.id);
  });

  for (int i=0;i<categories.length;i++) {
    final int documents = await FirebaseFirestore.instance.collection(
        'CoursesData').doc(categories[i]).collection("Courses").get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.length;
    });
    categoriesList.add({"name":categories[i],"Courses":documents});
  }
  return categoriesList;
}





Future<List<dynamic>> getCoursesFromFireBase(String subject)async
{





    List<dynamic> resultCourses =[];
    QuerySnapshot courses = await FirebaseFirestore.instance.collection(
        "CoursesData").get();
    courses.docs.forEach((element) {
      if (element.get(FieldPath(["CourseSubject"])) == subject) {
        resultCourses.add(element.data());
      }
    });
    return resultCourses;


}



Future<List<dynamic>> getExamsFromFireBase()async{




    List<dynamic> resultExams =[];
    QuerySnapshot exams = await FirebaseFirestore.instance.collection(
        "Exams").get();
    exams.docs.forEach((element) {

        resultExams.add(element.data());

    });
    return resultExams;

}






Future<DocumentReference<Map<String, dynamic>>> getStudentFromFireBaseAsStudent(String userid)async{

  DocumentReference<Map<String, dynamic>> student =  FirebaseFirestore.instance.collection(
      "Students").doc(userid);
 return student;



}




