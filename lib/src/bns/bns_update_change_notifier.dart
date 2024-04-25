import 'package:flutter/material.dart';

import 'bns_purchase_options.dart';

class BnsUpdateChangeNotifier extends ChangeNotifier{
  bool _disposed = false;

  int selectedBnsUpdateOption = 1;

  bool ownerAddressFieldIsValid = false;
  String ownerAddressFieldErrorMessage = '';

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

  void setOwnerAddressFieldIsValid(bool status) {
    ownerAddressFieldIsValid = status;
    notifyListeners();
  }

  void setOwnerAddressFieldErrorMessage(String errorMessage) {
    ownerAddressFieldErrorMessage = errorMessage;
    notifyListeners();
  }

  void setSelectedBnsUpdateOption(int selectedBnsUpdateOption) {
    this.selectedBnsUpdateOption = selectedBnsUpdateOption;
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

  void refresh(){
    notifyListeners();
  }

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