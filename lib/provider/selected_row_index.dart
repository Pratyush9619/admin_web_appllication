import 'package:flutter/foundation.dart';

class SelectedRowIndexModel extends ChangeNotifier {
  int _selectedRowIndex = -1;

  int get selectedRowIndex => _selectedRowIndex;

  void setSelectedRowIndex(int index) {
    _selectedRowIndex = index;
    notifyListeners();
  }
}
