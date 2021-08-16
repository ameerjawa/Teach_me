


import 'package:cloud_firestore/cloud_firestore.dart';

// function that we use in signin page to get the teacher when succesful signin
// ignore: missing_return
Future<DocumentSnapshot> getTeacherByIdFromFireBase(String id)async{
  try{
    CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
    return await teachers.doc(id).get();
  }catch(e){
    print("Exception is $e");
  }

}


// function that show all the students from the firebase
// ignore: missing_return
Stream<QuerySnapshot<Map<String, dynamic>>> showAllStudentsFromFireBase(){

  try{
    return FirebaseFirestore.instance
        .collection("Students").snapshots();
  }catch(e){
    print("Exception is $e");
  }


}

// function that select student from students list by name
// ignore: missing_return
Stream<QuerySnapshot<Map<String, dynamic>>> showStudentByNameFromFireBase(String selectedName){

  try{
    return FirebaseFirestore.instance
        .collection("Students").where("FullName",isEqualTo: selectedName)
        .snapshots();
  }catch(e){
    print("Exception is $e");

  }

}






// function that update the teacher details in firebase
Future<void>  updateTeacherDetailsFireBase(Map<String,dynamic> data, String userId)async{

  try{
    CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");

    await teachers.doc(userId).update(data);
  }catch(e){
    print("exception is $e");
  }



}

// function that store more data of the teacher {from Teachers_FireBase_Service}
Future<void> moreTeacherDetFromFireBase(Map<String, dynamic> data,
    CollectionReference collectionReference, String userId) async {
  try{
    collectionReference.doc(userId).update(data);
    return;
  }catch(e){
    print("Exception is $e");
  }

}



// function that get all the meetings from the firebase for spiciefic user
// ignore: missing_return
Future<List<dynamic>> getMeetingsFromFireBase(String userID)async{
  try{
    List<dynamic> resultMeetings =[];
    QuerySnapshot meetings = await FirebaseFirestore.instance.collection(
        "Meetings").get();
    meetings.docs.forEach((element) {
      if (element.get(FieldPath(["StudentId"])) == userID || element.get(FieldPath(["TeacherId"]))==userID) {
        resultMeetings.add(element.data());
      }
    });
    return resultMeetings;
  }catch(e){
    print("Exception $e");
  }


}

// function that get the teachers by subject and location


// ignore: missing_return
Stream<QuerySnapshot<Map<String, dynamic>>> getTeachersFromFireBaseBySubjectAndLocation(String subject,String location,bool showValue){
try{
  return location=="all" && subject=="all"?
  FirebaseFirestore.instance.collection('Teachers').snapshots():
  showValue?
  FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: location)
      .where("subjects",isEqualTo:subject).where("CanGo",isEqualTo: true).snapshots():
  FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: location)
      .where("subjects",arrayContains: subject).snapshots();
      }catch(e){
  print("Exception $e");
      }

}



