import 'dart:io';

import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/models/pair_params.dart';
import 'package:flutter/cupertino.dart';

class GetPairsParamsProvider with ChangeNotifier {
  PairParams? data;

  bool loading = false;
  bool _disposed = false;
  double minimumAmount = 0.0;
  double maximumAmount = 0.0;
  double sendAmountValue = 0.1;
  double getAmountValue = 0;
  bool errorState = false;
  bool sendCoinAvailableOnGetCoinStatus = false;
  bool getCoinAvailableOnSendCoinStatus = false;
  BaseExchangeService? _service;
  String? _error;
  String? get error => _error;

  void getPairsParamsData(context, List<Map<String, String>> params, String amount) async {
    loading = true;
    _error = null;
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
        //_error = 'No exchange selected';
        return;
      }
      if (params.isNotEmpty) {
        final from = params.first;
        final response = await _service!.getPairParams(
          fromCurrency: from['from'] ?? '',
          fromNetwork: from['fromNetwork'] ?? '',
          toCurrency: from['to'] ?? '',
          toNetwork: from['toNetwork'] ?? '',
          amount: amount ?? "0"
        );
        data = response;
        if (response != null) {
          minimumAmount = double.tryParse(response.minAmountFloat) ?? 0.0;
          maximumAmount = double.tryParse(response.maxAmountFloat) ?? 0.0;
        }
      }
    } on SocketException catch (e) {
      print('get pairs params api SocketException: Failed to connect: $e');
      //_error = "No internet connection.";
    } catch (e) {
      print('get pairs params api Unexpected error: $e');
      //_error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
  }

  void setSendValueMinimumAmountAndSendValueMaximumAmount(minimumAmount,maximumAmount){
    this.minimumAmount = minimumAmount;
    this.maximumAmount = maximumAmount;
    if(_disposed) return ;
    notifyListeners();
  }

  double getSendValueMinimumAmount(){
    return this.minimumAmount;
  }

  double getSendValueMaximumAmount(){
    return this.maximumAmount;
  }

  void setSendAmountValue(value){
    this.sendAmountValue = value;
    if(_disposed) return ;
    notifyListeners();
  }

  double getSendAmountValue(){
    return sendAmountValue;
  }

  void setGetAmountValue(value){
    this.getAmountValue = value;
    if(_disposed) return ;
    notifyListeners();
  }

  double getGetAmountValue(){
    return getAmountValue;
  }

  void setSendFieldErrorState(state){
    this.errorState = state;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSendFieldErrorState(){
    return this.errorState;
  }

  void setSendCoinAvailableOnGetCoinStatus(status){
    this.sendCoinAvailableOnGetCoinStatus = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSendCoinAvailableOnGetCoinStatus(){
    return this.sendCoinAvailableOnGetCoinStatus;
  }

  void setGetCoinAvailableOnSendCoinStatus(status){
    this.getCoinAvailableOnSendCoinStatus = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getGetCoinAvailableOnSendCoinStatus(){
    return this.getCoinAvailableOnSendCoinStatus;
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