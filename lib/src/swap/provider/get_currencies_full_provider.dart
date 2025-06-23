import 'dart:io';

import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:beldex_wallet/src/swap/util/utils.dart';
import 'package:flutter/cupertino.dart';

import '../api_service/get_currencies_full_api_service.dart';
import '../util/data_class.dart';

class GetCurrenciesFullProvider with ChangeNotifier {
  late GetCurrenciesFullModel? data;

  bool loading = true;
  bool? bdxIsEnabled;
  bool _disposed = false;
  Coins selectedYouSendCoins = btcCoin;
  Coins selectedYouGetCoins = bdxCoin;
  bool youSendCoinsDropDownVisible = false;
  bool youGetCoinsDropDownVisible = false;
  GetCurrenciesFullApiService services = GetCurrenciesFullApiService();
  String? _error;
  String? get error => _error;

  void getCurrenciesFullData(context) async {
    bdxIsEnabled = null;
    loading = true;
    _error = null;
    try {
      final response = await services.getSignature();
      if (response != null) {
        data = response;
      } else {
        _error = "Failed to fetch data.";
      }
    } on SocketException catch (e) {
      print('get currencies full api SocketException: Failed to connect: $e');
      _error = "No internet connection.";
    } catch (e) {
      print('get currencies full api Unexpected error: $e');
      _error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
  }

  void setBdxIsEnabled(status){
    this.bdxIsEnabled = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool? get getBdxIsEnabled => this.bdxIsEnabled;

  void setSelectedYouGetCoins(youGetCoins){
    this.selectedYouGetCoins = youGetCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouGetCoins(){
    return this.selectedYouGetCoins;
  }

  void setSelectedYouSendCoins(youSendCoins){
    this.selectedYouSendCoins = youSendCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouSendCoins(){
    return this.selectedYouSendCoins;
  }

  void setSendCoinsDropDownVisible(status){
    this.youSendCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSendCoinsDropDownVisible(){
    return this.youSendCoinsDropDownVisible;
  }

  void setGetCoinsDropDownVisible(status){
    this.youGetCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getGetCoinsDropDownVisible(){
    return this.youGetCoinsDropDownVisible;
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