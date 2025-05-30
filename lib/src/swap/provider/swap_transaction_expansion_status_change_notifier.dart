import 'package:flutter/material.dart';

class SwapTransactionExpansionStatusChangeNotifier extends ChangeNotifier{
  bool _disposed = false;
  final Map<int, bool> _expandedStatus = {};

  bool isExpanded(int index) => _expandedStatus[index] ?? false;

  void toggle(int index, bool isExpanded) {
    _expandedStatus[index] = isExpanded;
    notifyListeners();
  }

  bool? getStatus(int index) {
    return _expandedStatus[index];
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}

class test{
  test(this.id, this.status);
  int id ;
  bool status ;
}