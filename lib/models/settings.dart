import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  String _category = '';
  String _difficulty = '';

  String get getCategory {
    return _category;
  }

  String get getDifficulty {
    return _difficulty;
  }

  void chooseCategory(String c) {
    _category = c;
    notifyListeners();
  }

  void chooseDifficulty(String d) {
    _difficulty = d;
    notifyListeners();
  }
}
