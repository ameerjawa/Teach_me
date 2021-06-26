



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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


  // static function that get all the suvbjects from firebase


  static Future<List<dynamic>> getSubjects()async{
    return await getSubjectsFromFireBase();
  }


  // static function that get all the cities from firebase

  static Future<List<dynamic>>  getCities()async{

  return getCitiesFromFireBase();


  }

  void login(BuildContext context,CollectionReference teachers)async{
    try {
      final  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,

      );
      if(userCredential != null){
        DocumentSnapshot isTeacher = await teachers.doc("${userCredential.user.uid}").get();
        if(isTeacher.exists){
          //Student s;
          print("isTeacher");
          // Navigator.of(context).pushReplacement(CupertinoPageRoute(
          //     builder: (context) => Teacher_Homepage(isTeacher,s)
          // ));
        }else{
          print("isStudent");
          // Navigator.of(context).pushReplacement(CupertinoPageRoute(
          // //    builder: (context) => StudentActivity()
          // ));

        }
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }



}