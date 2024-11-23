import 'package:flutter/material.dart';

class LoginStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username;
  int? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;
  int? get userId => _userId;

  void logIn(int userId, String username) {
    _isLoggedIn = true;
    _userId = userId;
    _username = username;
    notifyListeners(); 
  }

  void logOut() {
    _isLoggedIn = false;
    _username = null;
    _userId = null;
    notifyListeners(); 
  }
}