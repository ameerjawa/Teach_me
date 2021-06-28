



import 'package:cloud_firestore/cloud_firestore.dart';


// function that edit the meeting details
Future<void> editMeetingToFireStoreAsTeacher(Map <String,dynamic> data,String meetingId)async{


  try{
    CollectionReference meetings = FirebaseFirestore.instance.collection("Meetings");

    await meetings.doc(meetingId).update(data);
  }catch(e){
    print("Exception is $e");
  }


}

// function that add new meetings to firebase
Future<void> addMeetingToFireStoreAsTeacher(Map <String,dynamic> data)async{
  try{
    CollectionReference meetings =  FirebaseFirestore.instance.collection("Meetings");

    await meetings.add(data);
  }catch(e){
    print("Exception is $e");
  }


}

// function that get all the meetings of speciefic Teacher

// ignore: missing_return
Stream<QuerySnapshot<Map<String, dynamic>>> getMeetingsByTeacherIdFromFireBase(String id){
  try{
    return   FirebaseFirestore.instance.collection('Meetings')
        .where("TeacherId" ,isEqualTo: id).snapshots();
  }catch(e){
    print("Exception is $e");
  }

}


// function that delete speciefic meeting from database
Future<void>  deleteMeetingByIdFromFireBase(String id)async{

  try{
    await FirebaseFirestore.instance.collection("Meetings").doc(id).delete();

  }catch(e){
    print("Exception is $e");
  }
}
