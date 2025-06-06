import 'package:flutter/material.dart';

class SwapTransactionExpansionStatusChangeNotifier extends ChangeNotifier{
  bool _disposed = false;
  final Map<int, bool> _expandedStatus = {};

  bool isExpanded(int index) => _expandedStatus[index] ?? false;

  void toggle(int index, bool isExpanded) {
    _expandedStatus[index] = isExpanded;
    if(_disposed) return ;
    notifyListeners();
  }

  bool? getStatus(int index) {
    return _expandedStatus[index];
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