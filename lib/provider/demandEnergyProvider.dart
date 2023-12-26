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

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Future<dynamic> Function()? _getCurrentDayData;
  Future<dynamic> Function()? get getCurrentDayData => _getCurrentDayData;

  Future<dynamic> Function()? _getCurrentMonthData;
  Future<dynamic> Function()? get getCurrentMonthData => _getCurrentMonthData;

  Future<dynamic> Function()? _getQuaterlyData;
  Future<dynamic> Function()? get getQuaterlyData => _getQuaterlyData;

  Future<dynamic> Function()? _getYearlyData;
  Future<dynamic> Function()? get getYearlyData => _getYearlyData;

  Future<dynamic> Function()? _getShowAlertWidget;
  Future<dynamic> Function()? get getShowAlertWidget => _getShowAlertWidget;

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

  void setSelectedIndex(int value) async {
    if (selectedDepo.isNotEmpty) {
      _selectedIndex = value;
      print('Selected Index: $value');

      switch (value) {
        case 0:
          await getCurrentDayData!();
          print('Current Day Data fetched from provider');
          break;
        case 1:
          await getCurrentMonthData!();
          print('Current Month Data fetched from provider');

          break;
        case 2:
          await getQuaterlyData!();
          print('Quaterly Data fetched from provider');

          break;
        case 3:
          await getYearlyData!();
          print('Yearly Day Data fetched from provider');
          break;

        default:
          break;
      }
      notifyListeners();
    } else {
      showAlertWidget();
    }
  }

  void setCurrentDayFunction(Future<dynamic> Function()? value) {
    _getCurrentDayData = value;
  }

  void setCurrentMonthFunction(Future<dynamic> Function()? value) {
    _getCurrentMonthData = value;
  }

  void setQuaterlyFunction(Future<dynamic> Function()? value) {
    _getQuaterlyData = value;
  }

  void setYearlyFunction(Future<dynamic> Function()? value) {
    _getYearlyData = value;
  }

  void setShowAlertWidget(Future<dynamic> Function()? value) {
    _getShowAlertWidget = value;
  }

  void showAlertWidget() {
    getShowAlertWidget!();
    print('Showing Alert Widget From Provider');
  }
}
