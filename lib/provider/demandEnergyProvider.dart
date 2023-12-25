import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DemandEnergyProvider extends ChangeNotifier {
  String _startDate = '';
  String get startDate => _startDate;

  String _endDate = '';
  String get endDate => _endDate;

  String _selectedCity = '';
  String get selectedCity => _selectedCity;

  bool _loadWidget = false;
  bool get loadWidget => _loadWidget;

  String _selectedDepo = '';
  String get selectedDepo => _selectedDepo;

  void reloadWidget(bool value) {
    _loadWidget = value;
    notifyListeners();
  }

  void setDepoName(String value) {
    _selectedDepo = value;
  }

  void setCityName(String value) {
    _selectedCity = value;
  }

  void setStartDate(String value) {
    _startDate = value;
  }

  void setEndDate(String value) {
    _endDate = value;
  }
}
