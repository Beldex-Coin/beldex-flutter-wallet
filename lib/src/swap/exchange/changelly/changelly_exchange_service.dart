import 'package:beldex_wallet/src/swap/api_service/get_currencies_full_api_service.dart';
import 'package:beldex_wallet/src/swap/api_service/get_exchange_amount_api_service.dart';
import 'package:beldex_wallet/src/swap/api_service/get_pairs_params_api_service.dart';
import 'package:beldex_wallet/src/swap/api_service/get_transactions_api_service.dart';
import 'package:beldex_wallet/src/swap/api_service/create_transaction_api_service.dart';
import 'package:beldex_wallet/src/swap/api_service/validate_address_api_service.dart';
import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/models/coin_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/exchange_rate.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_request.dart';
import 'package:beldex_wallet/src/swap/exchange/models/pair_params.dart';

import '../../util/utils.dart';

class ChangellyExchangeService extends BaseExchangeService {
  final _currenciesService = GetCurrenciesFullApiService();
  final _pairsService = GetPairsParamsApiService();
  final _exchangeAmountService = GetExchangeAmountApiService();
  final _validateAddressService = ValidateAddressApiService();
  final _createTransactionService = CreateTransactionApiService();
  final _getTransactionsService = GetTransactionsApiService();

  @override
  String get exchangeName => 'changelly';

  @override
  String get exchangeUrl => 'https://changelly.com';

  @override
  Future<List<CoinInfo>> getCurrencies() async {
    try {
      final response = await _currenciesService.getSignature();
      if (response?.result == null) return [];
      return response!.result!
          .where((c) => c.enabled == true)
          .map((c) => CoinInfo(
                name: c.name?.toUpperCase() ?? '',
                ticker: c.ticker ?? c.name,
                fullName: c.fullName ?? c.name ?? '',
                enabled: c.enabled ?? true,
                enabledFrom: c.enabledFrom ?? true,
                enabledTo: c.enabledTo ?? true,
                fixRateEnabled: c.fixRateEnabled ?? false,
                payinConfirmations: c.payinConfirmations ?? 0,
                extraIdName: c.extraIdName,
                logoUrl: c.image,
                protocol: c.protocol ?? c.contractAddress ?? '',
                network: c.blockchain ?? c.protocol ?? '',
                blockchain: c.blockchain
              ))
          .toList();
    } catch (e) {
      print('Changelly getCurrencies error: $e');
      return [];
    }
  }

  @override
  Future<PairParams?> getPairParams({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount
  }) async {
    try {
      final params = [
        {'from': fromCurrency.toLowerCase(), 'to': toCurrency.toLowerCase()}
      ];

      final response = await _pairsService.getSignature(params);
      if (response?.result == null || response!.result!.isEmpty) {
        return null;
      }
      return PairParams(
        fromCurrency: fromCurrency.toUpperCase(),
        toCurrency: toCurrency.toUpperCase(),
        minAmountFloat: response.result!.first.minAmountFloat ?? '0',
        maxAmountFloat: response.result!.first.maxAmountFloat ?? '0',
        minAmountFixed: response.result!.first.minAmountFixed ?? '0',
        maxAmountFixed: response.result!.first.maxAmountFixed ?? '0',
      );
    } catch (e) {
      print('Changelly getPairParams error: $e');
      return null;
    }
  }

  @override
  Future<ExchangeRate?> getExchangeRate({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount
  }) async {
    try {
      final params = {
        'from': fromCurrency.toLowerCase(),
        'to': toCurrency.toLowerCase(),
        'amountFrom': amount,
      };
      final response = await _exchangeAmountService.getSignature(params);
      if (response?.result == null || response!.result!.isEmpty) return null;
      final result = response.result!.first;
      return ExchangeRate(
        from: fromCurrency,
        to: toCurrency,
        amountFrom: result.amountFrom ?? amount,
        amountTo: result.amountTo ?? '0',
        rate: result.rate ?? '0',
        networkFee: result.networkFee,
        platformFee: result.fee ?? '0'
      );
    } catch (e) {
      print('Changelly getExchangeRate error: $e');
      return null;
    }
  }

  @override
  Future<bool> validateAddress({
    required String currency,
    required String network,
    required String address,
    String? memo,
  }) async {
    try {
      final params = {
        'currency': currency.toLowerCase(),
        'address': address,
      };
      if (memo != null && memo.isNotEmpty) {
        params['extraId'] = memo;
      }
      final response = await _validateAddressService.getSignature(params);
      return response?.result?.result ?? false;
    } catch (e) {
      print('Changelly validateAddress error: $e');
      return false;
    }
  }

  @override
  Future<OrderInfo?> createOrder(OrderRequest request) async {
    try {
      final params = {
        'from': request.fromCurrency.toLowerCase(),
        'to': request.toCurrency.toLowerCase(),
        'amount': request.depositAmount,
        'address': request.destinationAddress,
        'refundAddress': request.refundAddress ?? '',
      };
      if (request.destinationAddressMemo != null && request.destinationAddressMemo!.isNotEmpty) {
        params['extraId'] = request.destinationAddressMemo!;
      }
      final response = await _createTransactionService.getSignature(params);
      if (response?.result == null) return null;
      final result = response!.result!;
      return OrderInfo(
        orderId: result.id ?? '',
        type: 'float',
        networkFee: result.networkFee,
        platformFee: '0',
        apiExtraFee: result.apiExtraFee,
        payinAddress: result.payinAddress,
        payinExtraId: result.payinExtraId,
        payoutAddress: result.payoutAddress,
        payoutExtraId: result.payoutExtraId,
        refundAddress: result.refundAddress,
        refundExtraId: result.refundExtraId,
        amountExpectedFrom: result.amountExpectedFrom,
        amountExpectedTo: result.amountExpectedTo,
        amountTo: result.amountTo,
        status: result.status,
        currencyFrom: result.currencyFrom?.toLowerCase() ?? '',
        currencyTo: result.currencyTo?.toLowerCase() ?? '',
        payTill: DateTime.now().add(const Duration(minutes: 15)).toUtc().toIso8601String(),
        createdAt: toMsEpoch(result.createdAt),
        payinConfirmations: result.payinConfirmations ?? 0,
        rawResponse: result.toJson()
      );
    } catch (e) {
      print('Changelly createOrder error: $e');
      return null;
    }
  }

  @override
  Future<OrderInfoExtended?>  getOrderInfo(String orderId, String? destinationAddress) async {
    try {
      final params = {'id': orderId};
      final response = await _getTransactionsService.getSignature(params);
      if (response?.result == null) return null;
      final result = response!.result!;
      return OrderInfoExtended(
          orderId: result[0].id ?? '',
          type: 'float',
          networkFee: result[0].networkFee,
          platformFee: result[0].changellyFee,
          apiExtraFee: result[0].apiExtraFee,
          payinAddress: result[0].payinAddress,
          payinExtraId: result[0].payinExtraId,
          payoutAddress: result[0].payoutAddress,
          payoutExtraId: result[0].payoutExtraId,
          refundAddress: result[0].refundAddress,
          refundExtraId: result[0].refundExtraId,
          amountExpectedFrom: result[0].amountExpectedFrom,
          amountExpectedTo: result[0].amountExpectedTo,
          amountTo: result[0].amountTo,
          status: result[0].status,
          currencyFrom: result[0].currencyFrom?.toLowerCase() ?? '',
          currencyTo: result[0].currencyTo?.toLowerCase() ?? '',
          payTill: DateTime.now().add(const Duration(minutes: 15)).toUtc().toIso8601String(),
          createdAt: toMsEpoch(result[0].createdAt),
          payinConfirmations: result[0].payinConfirmations ?? 0,
          rawResponse: result[0].toJson(),
          rate: result[0].rate,
          moneyReceived: result[0].moneyReceived,
          moneySent: result[0].moneySent,
          payinHash: result[0].payinHash,
          payoutHashLink: result[0].payoutHashLink,
          payoutHash: result[0].payoutHash,
          payinExtraIdName: result[0].payinExtraIdName
      );
    } catch (e) {
      print('Changelly getOrderInfo error: $e');
      return null;
    }
  }
}
