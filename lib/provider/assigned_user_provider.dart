import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AssignedUserProvider with ChangeNotifier {
  String _reportingManager = '';
  String get reportingManager => _reportingManager;

  void setReportingManager(String value) {
    _reportingManager = value;
    notifyListeners();
  }
}
