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
      if (cached.isNotEmpty && ExchangeManager.hasFreshCurrencyCache) {
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

  bool? get getBdxIsEnabled => bdxIsEnabled;

  void setSelectedYouGetCoins(youGetCoins){
    selectedYouGetCoins = youGetCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouGetCoins(){
    return selectedYouGetCoins;
  }

  void setSelectedYouSendCoins(youSendCoins){
    selectedYouSendCoins = youSendCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouSendCoins(){
    return selectedYouSendCoins;
  }

  void setSendCoinsDropDownVisible(status){
    youSendCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSendCoinsDropDownVisible(){
    return youSendCoinsDropDownVisible;
  }

  void setGetCoinsDropDownVisible(status){
    youGetCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getGetCoinsDropDownVisible(){
    return youGetCoinsDropDownVisible;
  }

  @override
  void dispose() {
    try {
      _disposed = true;
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