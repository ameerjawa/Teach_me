


import 'package:cloud_firestore/cloud_firestore.dart';



// function that add an exam to the firebase as a Teacher
Future<void> addExamToFireBase(Map<String,dynamic> data )async{

  CollectionReference exams = FirebaseFirestore.instance.collection("Exams");

  await exams.add(data);

}


// function that get all the exams from the firebase
Future<List<dynamic>> getExamsFromFireBase()async{

  List<dynamic> resultExams =[];
  QuerySnapshot exams = await FirebaseFirestore.instance.collection(
      "Exams").get();
  exams.docs.forEach((element) {

    resultExams.add(element.data());

  });
  return resultExams;

}