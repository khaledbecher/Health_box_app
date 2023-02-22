import 'package:flutter/cupertino.dart';

class MainState with ChangeNotifier {
  bool _register = false;

  bool get register {
    return _register;
  }

  void changeRegister() {
    _register = !_register;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void changeisLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool _visible = false;

  bool get visible {
    return _visible;
  }

  void changeVisible() {
    _visible = !_visible;
    notifyListeners();
  }

  bool _visibleButtonsList = false;

  bool get visibleButtonsList {
    return _visibleButtonsList;
  }

  void changeVisibleButtonsList() {
    _visibleButtonsList = !_visibleButtonsList;
    notifyListeners();
  }
}
