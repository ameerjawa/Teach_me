

import 'dart:html';
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:teach_me/AppManagment/AccountType.dart';
import 'package:teach_me/AppManagment/StudentActivity.dart';

class User{


  final String Email;
  final String Password;
  final String VerifyPassword;
  final String FullName;
  final String BirthDate;
  final  String PhoneNumber;
  final String Location;
  final _auth= FirebaseAuth.instance;

  User(this.Email, this.Password, this.VerifyPassword, this.FullName, this.BirthDate, this.PhoneNumber, this.Location);


  void SignUp(BuildContext context)async {
    try{
      if (this.Password == this.VerifyPassword){
        final newUser = await  _auth.createUserWithEmailAndPassword(email: this.Email, password: this.Password);
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


  void Login(BuildContext context)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: this.Email,
        password: this.Password,
      );
      if(userCredential != null){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => StudentActivity()
        ));
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