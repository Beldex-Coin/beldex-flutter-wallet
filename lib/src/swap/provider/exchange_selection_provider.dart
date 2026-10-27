import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_provider.dart';
import 'package:flutter/material.dart';

class ExchangeSelectionProvider with ChangeNotifier {
  bool _disposed = false;
  bool _loading = false;
  String? _error;

  ExchangeProviderType? _selectedExchange;
  BaseExchangeService? _service;

  ExchangeProviderType? get selectedExchange => _selectedExchange;
  BaseExchangeService? get service => _service;
  bool get loading => _loading;
  String? get error => _error;

  String get exchangeName => _service?.exchangeName ?? '';
  String get exchangeUrl => _service?.exchangeUrl ?? '';
  bool get hasExchange => _service != null;

  /// Auto-select the first enabled exchange where BDX is available.
  Future<void> autoSelectExchange() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final service = await ExchangeManager.selectExchangeWithBdx();
      if (service != null) {
        _service = service;
        _selectedExchange = ExchangeManager.selectedType;
      } else {
        _service = null;
        _selectedExchange = null;
        //_error = 'No exchange available for BDX';
      }
    } catch (e) {
      _service = null;
      _selectedExchange = null;
      //_error = 'Failed to select exchange: $e';
    } finally {
      _loading = false;
      if (!_disposed) notifyListeners();
    }
  }

  /// Manually select a specific exchange.
  void setExchange(ExchangeProviderType type) {
    if (_selectedExchange == type) return;
    _selectedExchange = type;
    _service = ExchangeManager.getService(type);
    ExchangeManager.selectExchange(type);
    if (!_disposed) notifyListeners();
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
