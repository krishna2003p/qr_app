import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _currentView = 'login';

  String get currentView => _currentView;

  void switchView(String view) {
    _currentView = view;
    notifyListeners();
  }
}
