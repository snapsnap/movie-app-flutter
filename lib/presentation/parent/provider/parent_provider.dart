import 'package:flutter/material.dart';

class ParentProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  void setIndex(int value) {
    _selectedIndex = value;
  }
}
