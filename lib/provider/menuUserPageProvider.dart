import 'package:flutter/foundation.dart';

class MenuUserPageProvider with ChangeNotifier {
  bool _loadWidget = false;
  bool get cityName => _loadWidget;

  void setLoadWidget(bool value) {
    _loadWidget = value;
    notifyListeners();
  }
}
