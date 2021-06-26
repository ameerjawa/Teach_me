



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';




// function that we use in signin page to get the student when succesful signin {used by student}
Future<Student>  getStudentByIdFromFireBase(String id)async{
CollectionReference students = FirebaseFirestore.instance.collection("Students");
DocumentSnapshot studentSnapShot= await students.doc(id).get();

String fullName= studentSnapShot.get(FieldPath(["FullName"]));
String location= studentSnapShot.get(FieldPath(["Location"]));
String phoneNumber= studentSnapShot.get(FieldPath(["PhoneNumber"]));
String birthDate= studentSnapShot.get(FieldPath(["BirthDate"]));
String email= studentSnapShot.get(FieldPath(["Email"]));


Student student=new Student(email, "", "", fullName, birthDate, phoneNumber, location, false);

return student;


}



// function that get student from firebase by name {used By Teacher}

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