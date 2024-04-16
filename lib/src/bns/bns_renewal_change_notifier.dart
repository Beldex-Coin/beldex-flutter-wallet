import 'package:flutter/material.dart';

class BnsRenewalChangeNotifier extends ChangeNotifier{
  bool _disposed = false;
  int selectedBnsPriceIndex = 3;
  //bool bnsNameFieldIsValid = false;
  //String bnsNameFieldErrorMessage = '';

  void setSelectedBnsPriceIndex(int selectedBnsPriceIndex) {
    this.selectedBnsPriceIndex = selectedBnsPriceIndex;
    notifyListeners();
  }

 /* void setBnsNameFieldIsValid(bool status) {
    bnsNameFieldIsValid = status;
    notifyListeners();
  }

  void setBnsNameFieldErrorMessage(String errorMessage) {
    bnsNameFieldErrorMessage = errorMessage;
    notifyListeners();
  }*/

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}