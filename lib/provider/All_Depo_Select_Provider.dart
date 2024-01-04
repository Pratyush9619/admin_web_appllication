import 'package:flutter/foundation.dart';

class AllDepoSelectProvider with ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void setCheckedBool(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  void reloadCheckbox() {
    notifyListeners();
  }
}
