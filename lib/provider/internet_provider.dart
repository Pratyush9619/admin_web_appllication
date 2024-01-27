import 'package:flutter/material.dart';

import '../connectivity/connectivity_service.dart';


class ConnectivityProvider extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();
  late bool _isConnected;

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _isConnected = true;
    _connectivityService.connectionStatus.listen((bool isConnected) {
      _isConnected = isConnected;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }
}
