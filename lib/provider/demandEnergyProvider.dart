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

  List<double>? _allDepoDailyEnergyConsumedList;
  List<double>? get allDepoDailyEnergyConsumedList =>
      _allDepoDailyEnergyConsumedList;

  List<double>? _allDepoMonthlyEnergyConsumedList;
  List<double>? get allDepoMonthlyEnergyConsumedList =>
      _allDepoMonthlyEnergyConsumedList;

  List<double>? _allDepoQuaterlyEnergyConsumedList;
  List<double>? get allDepoQuaterlyEnergyConsumedList =>
      _allDepoQuaterlyEnergyConsumedList;

  List<double>? _allDepoYearlyEnergyConsumedList;
  List<double>? get allDepoYearlyEnergyConsumedList =>
      _allDepoYearlyEnergyConsumedList;

  double? _maxEnergyConsumed;
  double? get maxEnergyConsumed => _maxEnergyConsumed;

  List<dynamic>? _depoList;
  List<dynamic>? get depoList => _depoList;

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

  Future<dynamic> Function()? _getAllDepoDailyData;
  Future<dynamic> Function()? get getAllDepoDailyData => _getAllDepoDailyData;

  Future<dynamic> Function()? _getAllDepoMonthlyData;
  Future<dynamic> Function()? get getAllDepoMonthlyData =>
      _getAllDepoMonthlyData;

  Future<dynamic> Function()? _getAllDepoQuaterlyData;
  Future<dynamic> Function()? get getAllDepoQuaterlyData =>
      _getAllDepoQuaterlyData;

  Future<dynamic> Function()? _getAllDepoYearlyData;
  Future<dynamic> Function()? get getAllDepoYearlyData => _getAllDepoYearlyData;

  void setAllDepoDailyData(Future<dynamic> Function()? value) {
    _getAllDepoDailyData = value;
  }

  void setAllDepoMonthlyData(Future<dynamic> Function()? value) {
    _getAllDepoMonthlyData = value;
  }

  void setAllDepoQuaterlyData(Future<dynamic> Function()? value) {
    _getAllDepoQuaterlyData = value;
  }

  void setAllDepoYearlyData(Future<dynamic> Function()? value) {
    _getAllDepoYearlyData = value;
  }

  // GlobalKey<AnimatedListState>? _globalKey;

  // GlobalKey<AnimatedListState>? get globalKey => _globalKey;

  // List<List<dynamic>>? _rows;

  // List<List<dynamic>>? get rows => _rows;

  // int _rowLength = 0;

  // int get rowLength => _rowLength;

  // void resetRowData() {
  //   _rows!.clear();
  //   _rows!.add(['SrNo.', 'CityName', 'DepoName', 'Energy\nConsumed']);
  //   for (int i = 0; i < _rows!.length; i++) {
  //     _globalKey!.currentState!.removeItem(
  //       i,
  //       (context, animation) => Container(),
  //     );
  //     print('itemRemoved - $i');
  //   }
  //   _rowLength = 1;
  // }

  // void setRowHeaders() {
  //   _rows = [
  //     ['SrNo.', 'CityName', 'DepoName', 'Energy\nConsumed'],
  //   ];
  // }

  // void setRowLength(int value) {
  //   _rowLength = value;
  // }

  // void setGlobalKey(GlobalKey<AnimatedListState> value) {
  //   _globalKey = value;
  // }

  void setDepoList(List<dynamic> value) {
    _depoList = value;
  }

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

  void setAllDepoDailyConsumedList(List<double> value) {
    _allDepoDailyEnergyConsumedList = value;
  }

  void setAllDepoMonthlyConsumedList(List<double> value) {
    _allDepoMonthlyEnergyConsumedList = value;
  }

  void setAllDepoQuaterlyConsumedList(List<double> value) {
    _allDepoQuaterlyEnergyConsumedList = value;
  }

  void setAllDepoYearlyConsumedList(List<double> value) {
    _allDepoYearlyEnergyConsumedList = value;
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

  void setSelectedIndex(int value, bool isAllDepoChecked) async {
    _selectedIndex = value;

    if (isAllDepoChecked) {
      switch (value) {
        case 0:
          await getAllDepoDailyData!();
          _isLoadingBarCandle = false;
          print('All Depo Daily Data fetched from provider');

          break;
        case 1:
          await getAllDepoMonthlyData!();
          _isLoadingBarCandle = false;
          print('All Depo Monthly Day Data fetched from provider');

          break;
        case 2:
          await getAllDepoQuaterlyData!();
          _isLoadingBarCandle = false;
          print('All Depo Quaterly Data fetched from provider');

          break;
        case 3:
          await getAllDepoYearlyData!();
          _isLoadingBarCandle = false;
          print('All Depo Yearly Data fetched from provider');

          break;
      }
    } else if (isAllDepoChecked == false && selectedDepo.isNotEmpty) {
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
    } else {
      showAlertWidget();
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
