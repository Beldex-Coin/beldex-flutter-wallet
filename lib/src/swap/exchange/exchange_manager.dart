import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/changelly/changelly_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_provider.dart';
import 'package:beldex_wallet/src/swap/exchange/models/coin_info.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/swap_exchange_config.dart';

class ExchangeManager {
  ExchangeManager._();

  static final List<ExchangeProviderType> _enabledExchanges = [
    if (SwapExchangeConfig.changellyEnabled) ExchangeProviderType.changelly,
    if (SwapExchangeConfig.quickexEnabled) ExchangeProviderType.quickex,
  ];

  static List<ExchangeProviderType> get enabledExchanges => List.unmodifiable(_enabledExchanges);

  static bool get hasEnabledExchanges => _enabledExchanges.isNotEmpty;

  static BaseExchangeService? _selectedService;
  static ExchangeProviderType? _selectedType;
  static List<CoinInfo> _cachedCurrencies = [];

  static BaseExchangeService? get selectedService => _selectedService;
  static ExchangeProviderType? get selectedType => _selectedType;
  static List<CoinInfo> get cachedCurrencies => _cachedCurrencies;

  static BaseExchangeService _createService(ExchangeProviderType type) {
    switch (type) {
      case ExchangeProviderType.changelly:
        return ChangellyExchangeService();
      case ExchangeProviderType.quickex:
        return QuickexExchangeService();
    }
  }

  /// Check BDX availability across enabled exchanges.
  /// Returns the first exchange where BDX is enabled, or null.
  /// Currencies from the winning exchange are cached to avoid a duplicate API call.
  static Future<BaseExchangeService?> selectExchangeWithBdx() async {
    for (final type in _enabledExchanges) {
      try {
        final service = _createService(type);
        final currencies = await service.getCurrencies();
        final bdxAvailable = currencies.any(
          (c) => c.name.toUpperCase() == 'BDX' && c.enabled,
        );
        if (bdxAvailable) {
          _selectedService = service;
          _selectedType = type;
          _cachedCurrencies = currencies;
          return service;
        }
      } catch (e) {
        print('ExchangeManager: ${type.displayName} getCurrencies failed: $e');
        continue;
      }
    }
    _selectedService = null;
    _selectedType = null;
    _cachedCurrencies = [];
    return null;
  }

  /// Get service for a specific exchange type.
  static BaseExchangeService getService(ExchangeProviderType type) {
    return _createService(type);
  }

  /// Force-select a specific exchange (for manual selection).
  static void selectExchange(ExchangeProviderType type) {
    _selectedService = _createService(type);
    _selectedType = type;
  }

  static void clearSelection() {
    _selectedService = null;
    _selectedType = null;
    _cachedCurrencies = [];
  }
}
