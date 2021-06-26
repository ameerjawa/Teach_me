



import 'dart:io';
import 'package:teach_me/DBManagment/UserAccountManagment/User_FireBase_Service.dart';



class Userbg{


  final String email;
  final String password;
  final String verifyPassword;
  final String fullName;
  final String birthDate;
  final  String phoneNumber;
  final String location;

  Userbg(this.email, this.password, this.verifyPassword, this.fullName, this.birthDate, this.phoneNumber, this.location);


  // static function that get all the suvbjects from firebase {from User_FireBase_Service}
  static Future<List<dynamic>> getSubjects()async{
    return await getSubjectsFromFireBase();
  }


  // static function that get all the cities from firebase {from User_FireBase_Service}
  static Future<List<dynamic>>  getCities()async{

  return getCitiesFromFireBase();

  }

  // function that get an image file and upload it on firestore {from User_FireBase_Service}
  static Future<String> uploadImage(File imageFile,String userFullName,String userId)async{
    return await uploadImageToFireStorage(imageFile,userFullName,userId);
  }


}