

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';
import 'package:teach_me/AppManagment/Teacher_Homepage.dart';

class Userbg{


  final String email;
  final String password;
  final String verifyPassword;
  final String fullName;
  final String birthDate;
  final  String phoneNumber;
  final String location;
  final _auth= FirebaseAuth.instance;

  Userbg(this.email, this.password, this.verifyPassword, this.fullName, this.birthDate, this.phoneNumber, this.location);


  void signUp(BuildContext context)async {
    try{
      if (this.password == this.verifyPassword){
        final newUser = await  _auth.createUserWithEmailAndPassword(email: this.email, password: this.password);
        if(newUser != null){

          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => AccountType()
          ));
        }
      }
    }
    catch(e){
      print(e);

    }
  }


  void login(BuildContext context,CollectionReference Teachers)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential != null){
        DocumentSnapshot isTeacher = await Teachers.doc("${userCredential.user.uid}").get();
        if(isTeacher.exists){
          print("isTeacher");
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => Teacher_Homepage()
          ));
        }else{
          print("isStudent");
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => StudentActivity()
          ));

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