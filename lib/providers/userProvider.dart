import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  // Data Members
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  bool isLoading = true;
  // Getters
  User get getUser => _user!;

  // Functions

  Future<void> refreshUser() async {
   
    
    _user = await _authMethods.getUserDetails();
    isLoading = false;
    notifyListeners();
  }
}
