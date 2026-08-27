import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/changelly/changelly_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/exchange_provider.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_exchange_service.dart';

class ExchangeFactory {
  static final Map<ExchangeProviderType, BaseExchangeService> _instances = {};

  static BaseExchangeService getService(ExchangeProviderType type) {
    if (!_instances.containsKey(type)) {
      _instances[type] = _createService(type);
    }
    return _instances[type]!;
  }

  static BaseExchangeService _createService(ExchangeProviderType type) {
    switch (type) {
      case ExchangeProviderType.changelly:
        return ChangellyExchangeService();
      case ExchangeProviderType.quickex:
        return QuickexExchangeService();
    }
  }

  static void clearCache() {
    _instances.clear();
  }
}
