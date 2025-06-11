import 'dart:io';

import 'package:beldex_wallet/src/swap/api_service/get_pairs_params_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_pairs_params_model.dart';
import 'package:flutter/cupertino.dart';

class GetPairsParamsProvider with ChangeNotifier {
  late GetPairsParamsModel? data;

  bool loading = false;
  bool _disposed = false;
  double minimumAmount = 0.0;
  double maximumAmount = 0.0;
  double sendAmountValue = 0.1;
  double getAmountValue = 0;
  bool errorState = false;
  bool sendCoinAvailableOnGetCoinStatus = false;
  bool getCoinAvailableOnSendCoinStatus = false;
  GetPairsParamsApiService services = GetPairsParamsApiService();
  String? _error;
  String? get error => _error;

  void getPairsParamsData(context, List<Map<String, String>> params) async {
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
      if(_disposed) return;
      notifyListeners();
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
    return this.getAmountValue;
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