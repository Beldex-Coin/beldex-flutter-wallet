import 'dart:io';

import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/models/exchange_rate.dart';
import 'package:flutter/cupertino.dart';

class GetExchangeAmountProvider with ChangeNotifier {
  ExchangeRate? data;

  bool loading = true;
  bool _disposed = false;
  BaseExchangeService? _service;
  bool transactionStatus = false;
  String? _error;
  String? get error => _error;

  void getExchangeAmountData(Map<String, String> params) async {
    loading = true;
    _error = null;
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
        //_error = 'No exchange selected';
        return;
      }
      final response = await _service!.getExchangeRate(
        fromCurrency: params['from'] ?? '',
        fromNetwork: params['fromNetwork'] ?? '',
        toCurrency: params['to'] ?? '',
        toNetwork: params['toNetwork'] ?? '',
        amount: params['amountFrom'] ?? params['amount'] ?? '0'
      );
      if (response != null) {
        data = response;
      } else {
        //_error = "Failed to fetch data.";
      }
    } on SocketException catch (e) {
      print('get exchange amount api SocketException: Failed to connect: $e');
      //_error = "No internet connection.";
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      print('get exchange amount api error: $msg');
      //_error = msg;
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