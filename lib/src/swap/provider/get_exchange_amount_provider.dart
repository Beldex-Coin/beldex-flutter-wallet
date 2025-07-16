import 'dart:io';

import 'package:beldex_wallet/src/swap/api_service/get_exchange_amount_api_service.dart';
import 'package:flutter/cupertino.dart';
import '../model/get_exchange_amount_model.dart';

class GetExchangeAmountProvider with ChangeNotifier {
  late GetExchangeAmountModel? data;

  bool loading = true;
  bool _disposed = false;
  GetExchangeAmountApiService services = GetExchangeAmountApiService();
  bool transactionStatus = false;
  String? _error;
  String? get error => _error;

  void getExchangeAmountData(Map<String, String> params) async {
    loading = true;
    _error = null;
    try {
      final response = await services.getSignature(params);
      if (response != null) {
        data = response;
      } else {
        _error = "Failed to fetch data.";
      }
    } on SocketException catch (e) {
      print('get exchange amount api SocketException: Failed to connect: $e');
      _error = "No internet connection.";
    } catch (e) {
      print('get exchange amount api Unexpected error: $e');
      _error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
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