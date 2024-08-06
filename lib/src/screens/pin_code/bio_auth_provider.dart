import 'package:flutter/foundation.dart';

class ButtonClickNotifier with ChangeNotifier{
  bool _buttonClicked = false;
  bool get buttonClicked => _buttonClicked;

  void setButtonClicked(bool clicked){
    _buttonClicked = clicked;
    notifyListeners();
  }
}