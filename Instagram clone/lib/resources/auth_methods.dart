import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev/models/user.dart' as model;
import 'package:dev/resources/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.Userstr> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('user').doc(currentUser.uid).get();

    return model.Userstr.fromSnap(snap);
  }
  // sign up user
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethod()
            .uploadImageStorage('profilePics', file, false);

        model.Userstr user = model.Userstr(
            username: username,
            bio: bio,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            followers: [],
            following: [],
            email: email);
        //  user to firestore database
        await _firestore.collection('user').doc(cred.user!.uid).set(
              user.tojson(),
            );
        res = 'success';
      } else {
        res = 'Please enter all the fields include image';
      }
    } catch (err) {
      print('error ouccered');
      res = err.toString();
    }
    return res;
  }

//
//
//  Login Uer sign method
//
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('success');
        res = 'success';
      } else {
        res = 'please enter all the fields';
        print('Invalid Login');
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
