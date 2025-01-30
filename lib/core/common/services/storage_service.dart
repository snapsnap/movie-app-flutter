import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/const_storage.dart';

class StorageService {
  bool isLogin = false;

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  Future<void> init() async {
    await checkIfLogin();
  }

  Future<bool> writeSession(dynamic data) async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );

    await box.write(
      key: ConstStorage.isLoginKey,
      value: jsonEncode(true),
    );
    await box.write(
      key: ConstStorage.sessionKey,
      value: jsonEncode(data),
    );

    final bool hasSession = await box.containsKey(key: ConstStorage.sessionKey);

    if (!hasSession) {
      return false;
    } else {
      isLogin = true;
      return true;
    }
  }

  Future<dynamic> readSession() async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    final bool hasSession = await box.containsKey(key: ConstStorage.sessionKey);

    if (hasSession) {
      final sessionJson = await box.read(key: ConstStorage.sessionKey);
      if (sessionJson == null) {
        return null;
      }
      final session = jsonDecode(sessionJson);
      return session;
    } else {
      return null;
    }
  }

  Future<String> removeSession() async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    await box.delete(key: ConstStorage.isLoginKey);
    await box.delete(key: ConstStorage.sessionKey);

    final bool hasData = await box.containsKey(key: ConstStorage.sessionKey);

    if (!hasData) {
      isLogin = false;
      return ConstStorage.sessionRemoved;
    } else {
      return ConstStorage.sessionUnremoved;
    }
  }

  Future<bool> writeStorage(String key, dynamic data) async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    await box.write(
      key: key,
      value: jsonEncode(data),
    );

    final bool hasData = await box.containsKey(key: key);

    return hasData;
  }

  Future<dynamic> readStorage(String key) async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    final bool hasData = await box.containsKey(key: key);

    if (hasData) {
      final value = await box.read(key: key);
      if (value == null) {
        return "";
      }
      final result = jsonDecode(value);
      return result;
    } else {
      return "";
    }
  }

  Future<String> removeStorage(String key) async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    await box.delete(key: key);

    final bool hasData = await box.containsKey(key: key);
    if (kDebugMode) {
      print(hasData);
    }

    if (!hasData) {
      return "removed";
    } else {
      return "unremoved";
    }
  }

  Future<bool> checkIfLogin() async {
    final result = await readStorage(ConstStorage.isLoginKey);
    if (result == true) {
      isLogin = true;
      return true;
    } else {
      isLogin = false;
      return false;
    }
  }

  Future<String> getSavedToken() async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    final bool hasData = await box.containsKey(key: ConstStorage.savedTokenKey);

    if (hasData) {
      final dataJson = await box.read(key: ConstStorage.savedTokenKey);
      if (dataJson == null) {
        return "";
      }
      return jsonDecode(dataJson);
    } else {
      return "";
    }
  }

  Future<String> getSavedRefreshToken() async {
    final box = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: getIOSOptions(),
    );
    final bool hasData =
        await box.containsKey(key: ConstStorage.savedRefreshTokenKey);

    if (hasData) {
      final dataJson = await box.read(key: ConstStorage.savedRefreshTokenKey);
      if (dataJson == null) {
        return "";
      }
      return jsonDecode(dataJson);
    } else {
      return "";
    }
  }
}
