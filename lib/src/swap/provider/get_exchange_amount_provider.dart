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

  // True when the selected pair can't be traded (e.g. QuickEX "Pair not active").
  // Keeps the swap screen visible with an "Unsupported exchange pair" message.
  bool _pairUnsupported = false;
  bool get pairUnsupported => _pairUnsupported;

  void getExchangeAmountData(Map<String, String> params) async {
    loading = true;
    // Keep the last known pair state during the request so the build gate
    // doesn't fall through to a blank box while the rate call is in flight.
    if(!_disposed) notifyListeners();
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
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
        _pairUnsupported = false;
      } else {
        // No rate for this pair (Changelly returns null for unsupported
        // pairs), so mark it unsupported to keep the screen visible.
        _pairUnsupported = true;
      }
    } on SocketException catch (e) {
      print('get exchange amount api SocketException: Failed to connect: $e');
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      print('get exchange amount api error: $msg');
      // Unsupported/troubled pairs (e.g. "Pair ... not active",
      // "not available on QuickEX") keep the screen visible instead of blank.
      _pairUnsupported = RegExp(r'pair(?:.*?)\bnot (?:active|found)\b', caseSensitive: false)
              .hasMatch(msg) ||
          msg.toLowerCase().contains('not available on quickex');
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