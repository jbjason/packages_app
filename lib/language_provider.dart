import 'package:flutter/material.dart';
import 'package:packages_app/core/util/myconstant.dart';
import 'package:packages_app/core/util/myenum.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguageLocal = MyConstant.englishLocal;

  String get currentLanguageLocal => _currentLanguageLocal;

  void changeLanguage(LanguageType type) {
    if (type == LanguageType.english) {
      _currentLanguageLocal = MyConstant.englishLocal;
      notifyListeners();
    } else if (type == LanguageType.bangla) {
      _currentLanguageLocal = MyConstant.banglaLocal;
      notifyListeners();
    } else if (type == LanguageType.spanish) {
      _currentLanguageLocal = MyConstant.spanishLocal;
      notifyListeners();
    }
  }
}
