import 'package:flutter/foundation.dart';

class SelectedRowIndexModel extends ChangeNotifier {
  int _selectedRowIndex = -1;
  bool _loadWidget = false;

  bool get loadWidget => _loadWidget;

  int get selectedRowIndex => _selectedRowIndex;

  void setSelectedRowIndex(int index) {
    _selectedRowIndex = index;
    notifyListeners();
  }

  void loadWidgets(bool value) {
    _loadWidget = value;
    notifyListeners();
  }
}
