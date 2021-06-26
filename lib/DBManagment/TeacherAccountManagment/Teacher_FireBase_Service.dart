

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// static function that we use in signin page to get the teacher when succesful signin
Future<DocumentSnapshot> getTeacherByIdFromFireBase(String id)async{
  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
  return await teachers.doc(id).get();
}


// function that show all the students from the firebase
Stream<QuerySnapshot<Map<String, dynamic>>> showAllStudentsFromFireBase(){
  return FirebaseFirestore.instance
      .collection("Students").snapshots();

}

// function that select student from students list by name
Stream<QuerySnapshot<Map<String, dynamic>>> showStudentByNameFromFireBase(String selectedName){

  return FirebaseFirestore.instance
      .collection("Students").where("FullName",isEqualTo: selectedName)
      .snapshots();
}



// function that get a image file and store it in FireBaseFireStore
Future<String> uploadImageToFireStorage(File imageFile,String userFullName,String userId)async{


  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(imageFile.path);

  var snapshot = await _firebaseStorage.ref()
      .child('ProfileImages/$userFullName${userId}ProImage')
      .putFile(file).whenComplete(() => null);
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl.toString();


}


// function that update the teacher details in firebase
Future<void>  updateTeacherDetailsFireBase(Map<String,dynamic> data, String userId)async{

  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");

  await teachers.doc(userId).update(data);


}

// function that store more data of the teacher {from Teachers_FireBase_Service}
Future<void> moreTeacherDetFromFireBase(Map<String, dynamic> data,
    CollectionReference collectionReference, String userId) async {
  collectionReference.doc(userId).update(data);
  return;
}



// function that get all the meetings from the firebase for spiciefic user
Future<List<dynamic>> getMeetingsFromFireBase(String userID)async{
  List<dynamic> resultMeetings =[];
  QuerySnapshot meetings = await FirebaseFirestore.instance.collection(
      "Meetings").get();
  meetings.docs.forEach((element) {
    if (element.get(FieldPath(["StudentId"])) == userID || element.get(FieldPath(["TeacherId"]))==userID) {
      resultMeetings.add(element.data());
    }
  });
  return resultMeetings;

}


// function that get student from firebase by name

Future<List<dynamic>> getStudentFromFireBaseAsTeacher(String fullName)async{

  List<dynamic> resultStudents =[];
  QuerySnapshot students = await FirebaseFirestore.instance.collection(
      "Students").get();
  students.docs.forEach((element) {

    if (element.get(FieldPath(["FullName"]))==fullName) {
      resultStudents.add(element.data());
    }
  });
  return resultStudents;

}