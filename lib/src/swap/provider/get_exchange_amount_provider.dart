import 'package:beldex_wallet/src/swap/api_service/get_exchange_amount_api_service.dart';
import 'package:flutter/cupertino.dart';
import '../model/get_exchange_amount_model.dart';

class GetExchangeAmountProvider with ChangeNotifier {
  late GetExchangeAmountModel? data;

  bool loading = true;
  bool _disposed = false;
  GetExchangeAmountApiService services = GetExchangeAmountApiService();
  bool transactionStatus = false;

  void getExchangeAmountData(Map<String, String> params) async {
    loading = true;
    data = await services.getSignature(params);
    loading = false;
    if(_disposed) return ;
    notifyListeners();
  }

  void updateLoadingStatus(value){
    this.loading = value;
    if(_disposed) return ;
    notifyListeners();
  }

  void setTransactionStatus(status){
    this.transactionStatus = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getTransactionStatus(){
    return this.transactionStatus;
  }

  @override
  void dispose() {
    try {
      this._disposed = true;
      super.dispose();
    } catch(ex) {
      print("Exception-> $ex");
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}