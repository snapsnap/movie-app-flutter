import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../widgets/keys.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];

  List<ConnectivityResult> get connectionStatus => _connectionStatus;

  ConnectivityProvider() {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Could not check connectivity: $e');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _connectionStatus = result;
    notifyListeners();

    // Panggil Snackbar hanya saat koneksi berubah
    _showConnectivitySnackbar();
  }

  void _showConnectivitySnackbar() {
    String message = "Unknown Connection Status";
    for (var status in _connectionStatus) {
      switch (status) {
        case ConnectivityResult.wifi:
          message = "Connected to WiFi";
          break;
        case ConnectivityResult.mobile:
          message = "Connected to Mobile Network";
          break;
        case ConnectivityResult.none:
          message = "No Internet Connection";
          break;
        default:
          message = "Unknown Connection Status";
          break;
      }
    }

    // Pastikan snackbar bisa ditampilkan di mana saja
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
