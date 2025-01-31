import 'package:flutter/material.dart';

import '../../constants/const_storage.dart';
import '../../di/get_it.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final _storageService = getIt<StorageService>();
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final result =
        await _storageService.readStorage(ConstStorage.isDarkModeKey);
    _isDarkMode = result == true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storageService.writeStorage(ConstStorage.isDarkModeKey, _isDarkMode);
    notifyListeners();
  }
}
