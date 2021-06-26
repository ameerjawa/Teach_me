



import 'package:cloud_firestore/cloud_firestore.dart';


// function that edit the meeting details
Future<void> editMeetingToFireStoreAsTeacher(Map <String,dynamic> data,String meetingId)async{
  CollectionReference meetings = FirebaseFirestore.instance.collection("Meetings");

  await meetings.doc(meetingId).update(data);

}

// function that add new meetings to firebase
Future<void> addMeetingToFireStoreAsTeacher(Map <String,dynamic> data)async{
  CollectionReference meetings =  FirebaseFirestore.instance.collection("Meetings");

  await meetings.add(data);

}

// function that get all the meetings of speciefic Teacher

Stream<QuerySnapshot<Map<String, dynamic>>> getMeetingsByTeacherIdFromFireBase(String id){
  return   FirebaseFirestore.instance.collection('Meetings')
      .where("TeacherId" ,isEqualTo: id).snapshots();
}


// function that delete speciefic meeting from database
Future<void>  deleteMeetingByIdFromFireBase(String id)async{

  await FirebaseFirestore.instance.collection("Meetings").doc(id).delete();
}
