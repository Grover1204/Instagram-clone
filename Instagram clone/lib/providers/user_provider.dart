import 'package:dev/models/user.dart';
import 'package:dev/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as model;


class UserProvider with ChangeNotifier {

  final AuthMethods _authMethods = AuthMethods();
  
  Userstr? _user;

  Userstr get getUser =>_user!;

  Future<void> refershUser() async{
    Userstr user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}