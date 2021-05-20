
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/DBManagment/Lession.dart';
import 'file:///D:/ameer/teach_me/lib/UserManagment/TeacherManagment/TeacherProfiles.dart';

import '../../DBManagment/firebase.dart';
import '../Userbg.dart';

class Teacher extends Userbg with TeacherProfiles{

  final List<String> subjects;
 final String detailsOnExperience;
 final double rating=0;
 final int raters=0;
 final int allrateCount=0;
 final String proImg;


  Teacher(String email, String password, String verifyPassword, String fullName, String birthDate, String phoneNumber, String location, this.subjects, this.detailsOnExperience, this.proImg) : super(email, password, verifyPassword, fullName, birthDate, phoneNumber, location);





  void signUpASTeacher(Teacher newTeacher,CollectionReference collectionReference)async{

   var isTeacher=true;
    Map <String,dynamic> data = {"email":newTeacher.email,"ProfileImg":newTeacher.proImg,"FullName":newTeacher.fullName,"PhoneNumber":newTeacher.phoneNumber,"UserType":isTeacher,"Location":newTeacher.location,"BirthDate":newTeacher.birthDate,"Rating":newTeacher.rating} ;

    await userSetup(data,collectionReference);
}

  Future<void> addMeeting( Lession lession)async {

    Map<String,dynamic> data={"Date":lession.date, "StudentId": lession.studentId
    ,"StudentName"
        :lession.studentName,
    "TeacherId":
    lession.teacherId,
    "TeacherName":
    lession.teacherName,
    "Time":
    lession.Time};


    await addMeetingToFireStoreAsTeacher(data);
  }

  Future<void> editMeeting(Map <String,dynamic> data,String meetingId)async {
    await editMeetingToFireStoreAsTeacher(data,meetingId);
  }

  Future<List<dynamic>> getAllMeetings(String teacherId)async{
   return await getMeetingsFromFireBase(teacherId);
  }

  Future<List<dynamic>> searchForStudent(String email)async{
    return await getStudentFromFireBaseAsTeacher(email);
  }

  Future<void> addCourse(Map<String,dynamic> data)async{
    return await addCourseToFireBase(data);
  }



}