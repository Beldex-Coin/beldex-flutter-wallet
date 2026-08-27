import 'package:beldex_wallet/src/swap/exchange/exchange_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/models/exchange_rate.dart';

class GetExchangeAmountApiClient {
  ExchangeRate? data;

  Future<ExchangeRate?> getExchangeAmountData(context, Map<String, String> params) async {
    final service = ExchangeManager.selectedService;
    if (service == null) {
      return null;
    }
    data = await service.getExchangeRate(
      fromCurrency: params['from'] ?? '',
      fromNetwork: params['fromNetwork'] ?? '',
      toCurrency: params['to'] ?? '',
      toNetwork: params['toNetwork'] ?? '',
      amount: params['amountFrom'] ?? params['amount'] ?? '0',
    );
    return data;
  }
}
