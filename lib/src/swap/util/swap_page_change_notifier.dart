import 'package:flutter/cupertino.dart';

class SwapExchangePageChangeNotifier with ChangeNotifier {
  bool transactionHistoryScreenVisible = false;

  void setTransactionHistoryScreenVisibleStatus(bool status) {
    transactionHistoryScreenVisible = status;
    notifyListeners();
  }

  bool getTransactionHistoryVisibleStatus(){
    return transactionHistoryScreenVisible;
  }
}