


import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addCourseToFireBase(Map<String,dynamic> data)async{

  CollectionReference courses = FirebaseFirestore.instance.collection("CoursesData");

  await courses.add(data);

}