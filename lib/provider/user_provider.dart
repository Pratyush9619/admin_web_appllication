import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    notifyListeners();
  }

  String get userId {
    return _sharedPreferences.getString('employeeId') ?? '';
  }
}
