import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


Future<void> UserSetup(Map <String,dynamic> data,CollectionReference collectionReference)async{
  FirebaseAuth auth = FirebaseAuth.instance;
  String UserId = auth.currentUser.uid.toString();
  collectionReference.doc(UserId).set(data);
  return;
  
}



Future<void> UploadImagetofireStorage(File imageFile,String UserFullname,String UserId)async{
  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(imageFile.path);

  var snapshot = await _firebaseStorage.ref()
      .child('ProfileImages/${UserFullname}${UserId}ProImage')
      .putFile(file).whenComplete(() => null);
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;



}

