import 'dart:io';

import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/model/validate_address_model.dart';
import 'package:flutter/cupertino.dart';

class ValidateAddressProvider with ChangeNotifier {
  ValidateAddressResult? data;

  bool loading = true;
  bool _disposed = false;
  BaseExchangeService? _service;
  String recipientAddress = '';
  bool successState = true;
  String errorMessage = '';
  String? _error;
  String? get error => _error;

  void validateAddressData(context, Map<String, String> params) async {
    loading = true;
    _error = null;
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
        return;
      }
      final currency = params['currency'] ?? '';
      final address = params['address'] ?? '';
      final network = params['network'] ?? '';
      final memo = params['extraId'];
      final response = await _service!.validateAddress(
        currency: currency,
        network: network,
        address: address,
        memo: memo,
      );
      data = response;
      setSuccessState(response?.result ?? false);
    } on SocketException catch (e) {
      print('validate address api SocketException: Failed to connect: $e');
    } catch (e) {
      print('validate address api Unexpected error: $e');
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
  }

  void setRecipientAddress(address){
    this.recipientAddress = address;
    if(_disposed) return ;
    notifyListeners();
  }

  String getRecipientAddress(){
    return this.recipientAddress;
  }

  void setSuccessState(state){
    this.successState = state;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSuccessState(){
    return this.successState;
  }

  void setErrorMessage(message){
    this.errorMessage = message;
    if(_disposed) return ;
    notifyListeners();
  }

  String getErrorMessage(){
    return this.errorMessage;
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

class RefundValidateAddressProvider with ChangeNotifier {
  ValidateAddressResult? data;

  bool loading = true;
  bool _disposed = false;
  BaseExchangeService? _service;
  String recipientAddress = '';
  bool successState = true;
  String errorMessage = '';
  String? _error;
  String? get error => _error;

  void validateAddressData(context, Map<String, String> params) async {
    loading = true;
    _error = null;
    try {
      _service = ExchangeManager.selectedService;
      if (_service == null) {
        return;
      }
      final currency = params['currency'] ?? '';
      final address = params['address'] ?? '';
      final network = params['network'] ?? '';
      final memo = params['extraId'];
      final response = await _service!.validateAddress(
        currency: currency,
        network: network,
        address: address,
        memo: memo,
      );
      data = response;
      setSuccessState(response?.result ?? false);
    } on SocketException catch (e) {
      print('refund validate address SocketException: $e');
    } catch (e) {
      print('refund validate address error: $e');
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
  }

  void setRecipientAddress(address){
    this.recipientAddress = address;
    if(_disposed) return ;
    notifyListeners();
  }

  String getRecipientAddress(){
    return this.recipientAddress;
  }

  void setSuccessState(state){
    this.successState = state;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSuccessState(){
    return this.successState;
  }

  void setErrorMessage(message){
    this.errorMessage = message;
    if(_disposed) return ;
    notifyListeners();
  }

  String getErrorMessage(){
    return this.errorMessage;
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
