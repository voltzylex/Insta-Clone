import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    refreshUser();
  }
  // Data Members
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  bool isLoading = false;
  // Getters
  User? get user => _user;
  // Functions
  //
  Future<void> refreshUser() async {
    isLoading = true;
    notifyListeners();
    _user = await _authMethods.getUserDetails();
    isLoading = false;
    notifyListeners();
  }
}
