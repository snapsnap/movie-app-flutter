import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/const_storage.dart';
import '../../di/get_it.dart';
import '../services/storage_service.dart';

class TranslationProvider extends ChangeNotifier {
  final StorageService _storageService = getIt<StorageService>();

  Map<String, String> _translations = {};
  Locale _locale = const Locale('id', 'ID');

  Locale get locale => _locale;
  Map<String, String> get translations => _translations;

  /// **Memuat terjemahan berdasarkan Locale yang dipilih**
  Future<void> loadTranslations(Locale locale) async {
    try {
      _locale = locale;
      String languageCode = locale.languageCode;
      String path = 'assets/languages/$languageCode.json';

      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _translations =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading translations: $e');
    }
  }

  /// **Menerjemahkan teks berdasarkan key**
  String translate(String key) {
    return _translations[key] ?? key;
  }

  /// **Mengubah bahasa dan menyimpan ke Storage**
  Future<bool> changeLanguage(Locale newLocale) async {
    bool result = await saveLocaleToStorage(newLocale);
    if (result) {
      await loadTranslations(newLocale);
    }
    return result;
  }

  /// **Menyimpan Locale ke Storage**
  Future<bool> saveLocaleToStorage(Locale newLocale) async {
    try {
      final String stringLocale =
          '${newLocale.languageCode}_${newLocale.countryCode}';
      return await _storageService.writeStorage(
          ConstStorage.localeKey, stringLocale);
    } catch (e) {
      debugPrint('Error saving locale: $e');
      return false;
    }
  }

  /// **Mengambil Locale yang tersimpan di Storage**
  Future<Locale> getSavedLocale() async {
    try {
      final String? savedStringLocale =
          await _storageService.readStorage(ConstStorage.localeKey);
      return getLocaleFromString(savedStringLocale ?? 'id_ID');
    } catch (e) {
      debugPrint('Error getting saved locale: $e');
      return const Locale('id', 'ID'); // Fallback jika terjadi error
    }
  }

  /// **Mengubah String menjadi Locale**
  Locale getLocaleFromString(String localeString) {
    try {
      final parts = localeString.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
      return const Locale('id', 'ID'); // Fallback jika format salah
    } catch (e) {
      debugPrint('Error parsing locale string: $e');
      return const Locale('id', 'ID'); // Fallback jika terjadi error
    }
  }
}
