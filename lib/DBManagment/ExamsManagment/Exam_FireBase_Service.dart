


import 'package:cloud_firestore/cloud_firestore.dart';



// function that add an exam to the firebase as a Teacher
Future<void> addExamToFireBase(Map<String,dynamic> data )async{

  CollectionReference exams = FirebaseFirestore.instance.collection("Exams");

  await exams.add(data);

}
