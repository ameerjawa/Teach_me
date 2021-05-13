
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/AppManagment/Sign_Up_Teacher.dart';

import '../../firebase.dart';
import '../User.dart';

class Teacher extends User{

  final List<String> subjects;
 final String DetailsOnExperience;

  Teacher(String Email, String Password, String VerifyPassword, String FullName, String BirthDate, String PhoneNumber, String Location, this.subjects, this.DetailsOnExperience) : super(Email, Password, VerifyPassword, FullName, BirthDate, PhoneNumber, Location);





  void Sign_UpASTeacher(Map <String,dynamic> data,CollectionReference collectionReference)async{
    await UserSetup(data,collectionReference);
}

}