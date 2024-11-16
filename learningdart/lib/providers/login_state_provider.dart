import 'package:flutter/material.dart';

class LoginStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void logIn() {
    _isLoggedIn = true;
    notifyListeners(); 
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners(); 
  }
}