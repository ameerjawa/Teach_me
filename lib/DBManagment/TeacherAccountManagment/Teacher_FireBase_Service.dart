

import 'package:cloud_firestore/cloud_firestore.dart';

// function that we use in signin page to get the teacher when succesful signin
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

// function that get the teachers by subject and location


Stream<QuerySnapshot<Map<String, dynamic>>> getTeachersFromFireBaseBySubjectAndLocation(String subject,String location,bool showValue){
  return location=="all" && subject=="all"?
  FirebaseFirestore.instance.collection('Teachers').snapshots():
  showValue?
  FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: location)
      .where("subjects",isEqualTo:subject).where("CanGo",isEqualTo: true).snapshots():
  FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: location)
      .where("subjects",arrayContains: subject).snapshots();

}

