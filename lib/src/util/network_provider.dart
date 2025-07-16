import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'network_utils.dart';

class NetworkProvider with ChangeNotifier {

  NetworkProvider() {
    _initialize();
  }
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void _initialize() async {
    await _checkConnection();

    _subscription = NetworkUtils.connectivityStream.listen((result) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    _isConnected = await NetworkUtils.isNetworkConnected();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}