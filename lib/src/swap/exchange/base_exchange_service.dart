import 'package:beldex_wallet/src/swap/exchange/models/coin_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/exchange_rate.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_request.dart';
import 'package:beldex_wallet/src/swap/exchange/models/pair_params.dart';

abstract class BaseExchangeService {
  String get exchangeName;
  String get exchangeUrl;

  Future<List<CoinInfo>> getCurrencies();

  Future<PairParams?> getPairParams({
      required String fromCurrency,
      required String fromNetwork,
      required String toCurrency,
      required String toNetwork,
      required String amount
  });

  Future<ExchangeRate?> getExchangeRate({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount
  });

  Future<bool> validateAddress({
    required String currency,
    required String network,
    required String address,
    String? memo,
  });

  Future<OrderInfo?> createOrder(OrderRequest request);

  Future<OrderInfo?> getOrderInfo(String orderId, String? destinationAddress);
}
