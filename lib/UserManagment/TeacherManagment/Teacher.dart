
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/DBManagment/CoursesManagment/Course_FireBase_Service.dart';
import 'package:teach_me/DBManagment/ExamsManagment/Exam_FireBase_Service.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Lession.dart';
import 'package:teach_me/DBManagment/MeetingsManagment/Meetings_FireBase_Service.dart';
import 'package:teach_me/DBManagment/TeacherAccountManagment/Teacher_FireBase_Service.dart';
import 'package:teach_me/DBManagment/UserAccountManagment/User_FireBase_Service.dart';
import 'package:teach_me/UserManagment/TeacherManagment/TeacherProfiles.dart';

import '../Userbg.dart';

class Teacher extends Userbg with TeacherProfiles{

  final List<dynamic> subjects;
 final String detailsOnExperience;
 final double rating;
 final int rater=0;
 final bool  canGo;
 final int allrateCount=0;
 final String TitleSentence;
 final String proImg;
 final String id;
 final int price;


  Teacher(String email, String password, String verifyPassword, String fullName, String birthDate, String phoneNumber, String location, this.subjects, this.detailsOnExperience, this.proImg, this.rating, this.canGo, this.id, this.TitleSentence, this.price) : super(email, password, verifyPassword, fullName, birthDate, phoneNumber, location);





  // static function that we use in signin page to get the teacher when succesful signin {from Teacher_FireBase_Service}

  static Future<DocumentSnapshot>  getTeacherById(String id)async{

    return await getTeacherByIdFromFireBase(id);



  }
  // function that show all the students from the firebase {from Teacher_FireBase_Service}
  Stream<QuerySnapshot<Map<String, dynamic>>> showAllStudents(){
    return showAllStudentsFromFireBase();

  }

  // function that select student from students list by name {from Teacher_FireBase_Service}
  Stream<QuerySnapshot<Map<String, dynamic>>> showStudentByName(String selectedName){
    return showStudentByNameFromFireBase(selectedName);
  }


  // function that edit the meeting details  {from Meetings_FireBase_Service}
   Future<void> editMeeting(Map <String,dynamic> data,String meetingId)async{
    await editMeetingToFireStoreAsTeacher(data,meetingId);
  }


  // function that add new meetings to firebase {from Meetings_FireBase_Service}
   Future<void> addMeeting( Lesson lesson)async {
    Map<String,dynamic> data={"Date":lesson.date,"StuPhoneNumber":lesson.studentphonenumber,"LessonSubject":lesson.subject
      ,"StudentName"
          :lesson.studentName,
      "TeacherId":
      lesson.teacherId,
      "TeacherName":
      lesson.teacherName,
      "Time":
      lesson.time};
    await addMeetingToFireStoreAsTeacher(data);
  }



// function that get all the meetings of speciefic Teacher {from Meetings_FireBase_Service}
   Stream<QuerySnapshot<Map<String, dynamic>>> getMeetingsByTeacherId(String id){
    return   getMeetingsByTeacherIdFromFireBase(id);
  }


  // function that delete speciefic meeting from database {from Meetings_FireBase_Service}
  Future<void>  deleteMeetingById(String id)async{

    await deleteMeetingByIdFromFireBase(id);
  }


  // function that get an image file and upload it on firestore {from Teachers_FireBase_Service}
  static Future<String> uploadImage(File imageFile,String userFullName,String userId)async{
    return await uploadImageToFireStorage(imageFile,userFullName,userId);
  }

  // function that update the teacher details {from Teachers_FireBase_Service}
  Future<void> updateTeacherDetails(Map<String,dynamic> data, String userId)async{
  await  updateTeacherDetailsFireBase(data,userId);
  }

  // function that store more data of the teacher {from Teachers_FireBase_Service}
  Future<void> moreTeacherDet(Map<String, dynamic> data,
      CollectionReference collectionReference, String userId) async {
   return moreTeacherDetFromFireBase(data,collectionReference,userId);
  }





// function that regiester the Teacher in the firebasefirestore {from User_FireBase_service}
  Future<void> signUpASTeacher(Teacher newTeacher,CollectionReference collectionReference,String userId)async{

   var isTeacher=true;
    Map <String,dynamic> data = {"email":newTeacher.email,"ProfileImg":newTeacher.proImg,"FullName":newTeacher.fullName,"PhoneNumber":newTeacher.phoneNumber,"UserType":isTeacher,"Location":newTeacher.location,"BirthDate":newTeacher.birthDate,"Rating":newTeacher.rating} ;

    await userSetup(data,collectionReference,userId);
  }





   // function that get all the meetings from the firebase for spiciefic user{from Teacher_FireBase_Service}
  Future<List<dynamic>> getAllMeetings(String teacherId)async{
   return await getMeetingsFromFireBase(teacherId);
  }



  // function that get student from firebase by name {from Teacher_FireBase_Service}
  Future<List<dynamic>> searchForStudent(String email)async{
    return await getStudentFromFireBaseAsTeacher(email);
  }



  // function that add acourse to the firebase {from Course_FireBase_Service}
  Future<void> addCourse(Map<String,dynamic> data)async{
    return await addCourseToFireBase(data);
  }

  Future<void> addExam(Map<String,dynamic> data){

    return  addExamToFireBase(data);

  }



}