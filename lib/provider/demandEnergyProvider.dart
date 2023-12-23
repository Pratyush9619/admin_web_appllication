import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DemandEnergyProvider extends ChangeNotifier {
  bool _loadWidget = false;
  bool get loadWidget => _loadWidget;

  String _selectedDepo = '';
  String get selectedDepo => _selectedDepo;

  void reloadWidget(bool value) {
    _loadWidget = value;
    notifyListeners();
  }

  void getDepoName(String value) {
    _selectedDepo = value;
  }
}
