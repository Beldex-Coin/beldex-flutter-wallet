import 'dart:async';
import 'dart:io';

import 'package:beldex_wallet/src/swap/api_service/get_transactions_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter/cupertino.dart';

class GetTransactionsProvider with ChangeNotifier {
  late GetTransactionsModel? data;

  bool loading = true;
  bool _disposed = false;
  GetTransactionsApiService services = GetTransactionsApiService();
  String? _error;
  String? get error => _error;

  void getTransactionsData(context, Map<String, String> params) async {
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
      print('get transactions api SocketException: Failed to connect: $e');
      _error = "No internet connection.";
    } catch (e) {
      print('get transactions api Unexpected error: $e');
      _error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(_disposed) return;
      notifyListeners();
    }
  }

  void getTransactionsListData(context, Map<String, List<String>> params) async {
    loading = true;
    _error = null;
    try {
      final response = await services.getSignatureWithIds(params);
      if (response != null) {
        data = response;
      } else {
        _error = "Failed to fetch data.";
      }
    } on SocketException catch (e) {
      print('get transactions list api SocketException: Failed to connect: $e');
      _error = "No internet connection.";
    } catch (e) {
      print('get transactions list api Unexpected error: $e');
      _error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(_disposed) return;
      notifyListeners();
    }
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