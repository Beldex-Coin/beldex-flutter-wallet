import 'package:flutter/material.dart';

import 'bns_purchase_options.dart';

class BuyBnsChangeNotifier extends ChangeNotifier{
  int selectedBnsPriceIndex = 3;
  bool bnsNameFieldIsValid = false;
  String bnsNameFieldErrorMessage = '';

  bool walletAddressFieldIsValid = false;
  String walletAddressFieldErrorMessage = '';

  bool bchatIdFieldIsValid = false;
  String bchatIdFieldErrorMessage = '';

  bool belnetIdFieldIsValid = false;
  String belnetIdFieldErrorMessage = '';

  List<BnsPurchaseOptions> bnsPurchaseOptions = [
    BnsPurchaseOptions('Address', true),
    BnsPurchaseOptions('BChat ID', false),
    BnsPurchaseOptions('Belnet ID', false)
  ];

  void setSelectedBnsPriceIndex(int selectedBnsPriceIndex) {
    this.selectedBnsPriceIndex = selectedBnsPriceIndex;
    notifyListeners();
  }

  void setBnsNameFieldIsValid(bool status) {
    bnsNameFieldIsValid = status;
    notifyListeners();
  }

  void setBnsNameFieldErrorMessage(String errorMessage) {
    bnsNameFieldErrorMessage = errorMessage;
    notifyListeners();
  }

  void updateBnsPurchaseOptionsStatus(int selectedIndex,bool status){
    bnsPurchaseOptions[selectedIndex].selected = status;
    notifyListeners();
  }

  void setWalletAddressFieldIsValid(bool status) {
    walletAddressFieldIsValid = status;
    notifyListeners();
  }

  void setWalletAddressFieldErrorMessage(String errorMessage) {
    walletAddressFieldErrorMessage = errorMessage;
    notifyListeners();
  }

  void setBchatIdFieldIsValid(bool status) {
    bchatIdFieldIsValid = status;
    notifyListeners();
  }

  void setBchatIdFieldErrorMessage(String errorMessage) {
    bchatIdFieldErrorMessage = errorMessage;
    notifyListeners();
  }

  void setBelnetIdFieldIsValid(bool status) {
    belnetIdFieldIsValid = status;
    notifyListeners();
  }

  void setBelnetIdFieldErrorMessage(String errorMessage) {
    belnetIdFieldErrorMessage = errorMessage;
    notifyListeners();
  }
}