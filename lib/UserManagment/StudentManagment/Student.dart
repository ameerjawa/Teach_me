
import 'dart:html';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase.dart';
import '../User.dart';

class Student extends User{

  final bool isMale;
  int grade;

  Student(String Email, String Password, String VerifyPassword, String FullName, String BirthDate, String PhoneNumber, String Location, this.isMale) : super(Email, Password, VerifyPassword, FullName, BirthDate, PhoneNumber, Location);







  void SignUpAS_Student(Map <String,dynamic> data,CollectionReference collectionReference)async{
    await UserSetup(data,collectionReference);
  }




}