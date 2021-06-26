
 import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<dynamic>> getSubjectsFromFireBase()async{
CollectionReference Subjectscollection =
FirebaseFirestore.instance.collection("Subjects");
DocumentSnapshot<Object> subjects= await Subjectscollection.doc("rFoR8RQBWc49Rx159ljf").get();
return subjects.get("subjects");
}

 // static function that get all the cities from firebase
  Future<List<dynamic>>  getCitiesFromFireBase()async{

 CollectionReference citiescollection=FirebaseFirestore.instance.collection("Cities");
 DocumentSnapshot<Object> cities= await citiescollection.doc("eF4F8hC9Y6QJjm1fRXXN").get();
 return cities.get("cities");


 }



 // sign up users Teacher and Student
 Future<void> userSetup(Map <String,dynamic> data,CollectionReference collectionReference,String userId)async{
  collectionReference.doc(userId).set(data);
  return;

 }
