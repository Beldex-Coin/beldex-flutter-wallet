import 'dart:io';

import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/models/coin_info.dart';
import 'package:beldex_wallet/src/swap/util/utils.dart';
import 'package:flutter/cupertino.dart';

import '../util/data_class.dart';

class GetCurrenciesFullProvider with ChangeNotifier {
  List<CoinInfo> data = [];

  bool loading = true;
  bool? bdxIsEnabled;
  bool _disposed = false;
  Coins selectedYouSendCoins = btcCoin;
  Coins selectedYouGetCoins = bdxCoin;
  bool youSendCoinsDropDownVisible = false;
  bool youGetCoinsDropDownVisible = false;
  BaseExchangeService? _service;
  String? _error;
  String? get error => _error;

  void getCurrenciesFullData(context) async {
    bdxIsEnabled = null;
    loading = true;
    _error = null;
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
        bdxIsEnabled = false;
        return;
      }
      final cached = ExchangeManager.cachedCurrencies;
      if (cached.isNotEmpty) {
        data = cached;
      } else {
        data = await _service!.getCurrencies();
      }
      bdxIsEnabled = data.any(
        (c) => c.name.toUpperCase() == 'BDX' && c.enabled,
      );
    } on SocketException catch (e) {
      print('get currencies full api SocketException: Failed to connect: $e');
      //_error = "No internet connection.";
    } catch (e) {
      print('get currencies full api Unexpected error: $e');
      //_error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
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