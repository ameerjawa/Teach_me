
 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


 // static function that get all the Subjects from firebase
// ignore: missing_return
Future<List<dynamic>> getSubjectsFromFireBase()async{

 try{
  CollectionReference subjectsCollection =
  FirebaseFirestore.instance.collection("Subjects");
  DocumentSnapshot<Object> subjects= await subjectsCollection.doc("rFoR8RQBWc49Rx159ljf").get();
  return subjects.get("subjects");
 }catch(e){
  print("Eception $e");
 }

}

 // static function that get all the cities from firebase
  // ignore: missing_return
  Future<List<dynamic>>  getCitiesFromFireBase()async{

 try{
  CollectionReference citiescollection=FirebaseFirestore.instance.collection("Cities");
  DocumentSnapshot<Object> cities= await citiescollection.doc("eF4F8hC9Y6QJjm1fRXXN").get();
  return cities.get("cities");
 }catch(e){
  print("Exception is $e");
 }



 }



 // sign up users Teacher and Student
 Future<void> userSetup(Map <String,dynamic> data,CollectionReference collectionReference,String userId)async{
 try{
  collectionReference.doc(userId).set(data);
  return;
 }catch(e){
  print("Exception is $e");
 }


 }


 // function that get a image file and store it in FireBaseFireStore
 // ignore: missing_return
 Future<String> uploadImageToFireStorage(File imageFile,String userFullName,String userId)async{


 try{
  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(imageFile.path);

  var snapshot = await _firebaseStorage.ref()
      .child('ProfileImages/$userFullName${userId}ProImage')
      .putFile(file).whenComplete(() => null);
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl.toString();
 }catch(e){
  print("Exception is $e");
 }



 }



 ////////////////// ADD Courses To DB ///////////////////////


 // await  FirebaseFirestore.instance.collection("CoursesData").doc("Math").collection("Courses").add(
 //     {"CourseName":"Partial Differential Equations","Titles":Titles,"Videos":Videos,"videoscount":10});
