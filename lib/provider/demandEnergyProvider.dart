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

  List<double>? _dailyEnergyConsumed;
  List<double>? get dailyEnergyConsumed => _dailyEnergyConsumed;

  double? _monthlyEnergyConsumed;
  double? get monthlyEnergyConsumed => _monthlyEnergyConsumed;

  List<double>? _quaterlyEnergyConsumedList;
  List<double>? get quaterlyEnergyConsumedList => _quaterlyEnergyConsumedList;

  List<double>? _yearlyEnergyConsumedList;
  List<double>? get yearlyEnergyConsumedList => _yearlyEnergyConsumedList;

  double? _maxEnergyConsumed;
  double? get maxEnergyConsumed => _maxEnergyConsumed;

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

  bool _isLoadingBarCandle = false;
  bool get isLoadingBarCandle => _isLoadingBarCandle;

  void setMaxEnergyConsumed(double value) {
    _maxEnergyConsumed = value;
  }

  void reloadWidget(bool value) {
    _loadWidget = value;
    notifyListeners();
  }

  void setDailyConsumedList(List<double> value) {
    _dailyEnergyConsumed = value;
  }

  void setQuaterlyConsumedList(List<double> value) {
    _quaterlyEnergyConsumedList = value;
  }

  void setYearlyConsumedList(List<double> value) {
    _yearlyEnergyConsumedList = value;
  }

  void setLoadingBarCandle(bool value) {
    _isLoadingBarCandle = value;
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
    _selectedIndex = value;
    print('Provider Selected Index: $value');

    switch (value) {
      case 0:
        await getCurrentDayData!();
        _isLoadingBarCandle = false;

        print('Current Day Data fetched from provider');
        break;
      case 1:
        await getCurrentMonthData!();
        _isLoadingBarCandle = false;

        print('Current Month Data fetched from provider');

        break;
      case 2:
        await getQuaterlyData!();
        _isLoadingBarCandle = false;

        print('Quaterly Data fetched from provider');

        break;
      case 3:
        await getYearlyData!();
        _isLoadingBarCandle = false;

        print('Yearly Day Data fetched from provider');
        break;

      default:
        break;
    }
    notifyListeners();
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

  void setMonthlyEnergyConsumed(double value) {
    _monthlyEnergyConsumed = value;
  }
}
