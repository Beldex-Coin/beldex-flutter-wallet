import 'package:beldex_wallet/src/swap/exchange/base_exchange_service.dart';
import 'package:beldex_wallet/src/swap/exchange/models/coin_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/exchange_rate.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_info.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_request.dart';
import 'package:beldex_wallet/src/swap/exchange/models/pair_params.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_api_service.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_order.dart';

import '../../util/utils.dart';

const Map<String, String> _quickexEventStatusMap = {
  'CREATION_END': 'waiting',
  'INCOMING_FUNDS_DETECTED': 'confirming',
  'DEPOSIT_REGISTERED': 'exchanging',
  'FUNDS_WITHDRAWAL_START': 'sending',
  'WITHDRAWAL_COMPLETED': 'finished',
};

/// Resolves a Quickex order to an app status string
/// ('waiting'/'confirming'/'exchanging'/'sending'/'finished'/'failed'/'overdue').
String resolveQuickexTxStatus(QuickexOrder order) {
  if (order.completed) return 'finished';
  if (order.failedToCreate) return 'failed';
  if (order.orderEvents.isNotEmpty) {
    final event = order.orderEvents.first;
    if (!isWithin3Hours(event.createdAt)) return 'overdue';
    return _quickexEventStatusMap[event.kind] ?? 'waiting';
  }
  if (order.isPendingToCreate) return "waiting";
  return 'waiting';
}

class QuickexExchangeService extends BaseExchangeService {
  final QuickexApiService _api = QuickexApiService();

  @override
  String get exchangeName => 'quickex';

  @override
  String get exchangeUrl => 'https://quickex.io';

  @override
  Future<List<CoinInfo>> getCurrencies() async {
    final instruments = await _api.getInstruments();
    return instruments
        .where((i) => i.instrumentType == 'crypto')
        .map((i) => CoinInfo(
              name: i.currencyTitle.toUpperCase() ?? '',
              ticker: i.currencyTitle.toLowerCase(),
              fullName: i.fullName.isNotEmpty ? i.fullName : i.currencyFriendlyTitle.isNotEmpty
                  ? i.currencyFriendlyTitle
                  : i.currencyTitle,
              enabled: true,
              enabledFrom: true,
              enabledTo: true,
              fixRateEnabled: true,
              payinConfirmations: 0,
              extraIdName: i.requiresMemo ? "memo" : null,
              logoUrl: i.logoUrl,
              protocol: i.networkTitle,
              network: i.networkTitle,
              blockchain: i.networkTitle,
            ))
        .toList();
  }

  @override
  Future<PairParams?> getPairParams({
      required String fromCurrency,
      required String fromNetwork,
      required String toCurrency,
      required String toNetwork,
      required String amount
  }) async {
    final result = await _api.getPairs(
      fromCurrency: fromCurrency.toUpperCase(),
      fromNetwork: fromNetwork.toUpperCase(),
      toCurrency: toCurrency.toUpperCase(),
      toNetwork: toNetwork.toUpperCase(),
      amount: amount
    );
    if (result.success && result.data != null) {
      final pairs = result.data!;
      return PairParams(
        fromCurrency: fromCurrency.toUpperCase(),
        toCurrency: toCurrency.toUpperCase(),
        minAmountFloat: pairs.minAmount?.isNotEmpty == true ? pairs.minAmount! : '0',
        maxAmountFloat: pairs.maxAmount?.isNotEmpty == true ? pairs.maxAmount! : '0',
        minAmountFixed: pairs.minAmount?.isNotEmpty == true ? pairs.minAmount! : '0',
        maxAmountFixed: pairs.maxAmount?.isNotEmpty == true ? pairs.maxAmount! : '0'
      );
    }
    if (result.minMaxHint != null) {
      return PairParams(
        fromCurrency: fromCurrency.toUpperCase(),
        toCurrency: toCurrency.toUpperCase(),
        minAmountFloat: result.minMaxHint!.minAmountFloat,
        maxAmountFloat: result.minMaxHint!.maxAmountFloat,
        minAmountFixed: result.minMaxHint!.minAmountFixed,
        maxAmountFixed: '0'
      );
    }
    return null;
  }

  @override
  Future<ExchangeRate?> getExchangeRate({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount,
  }) async {
    final result = await _api.getRate(
      fromCurrency: fromCurrency.toUpperCase(),
      fromNetwork: fromNetwork.toUpperCase(),
      toCurrency: toCurrency.toUpperCase(),
      toNetwork: toNetwork.toUpperCase(),
      amount: amount
    );
    if (result.success && result.data != null) {
      final rate = result.data!;
      return ExchangeRate(
        from: fromCurrency.toUpperCase(),
        to: toCurrency.toUpperCase(),
        amountFrom: amount,
        amountTo: rate.amountToGet ?? '0',
        rate: rate.price,
        networkFee: rate.finalNetworkFeeAmount,
      );
    }
    if (result.minMaxHint != null) {
      print("getExchangeRate success-> ${result.minMaxHint!.minAmountFloat}, ${result.minMaxHint!.maxAmountFloat}");
      return ExchangeRate(
        from: fromCurrency.toUpperCase(),
        to: toCurrency.toUpperCase(),
        amountFrom: amount,
        amountTo: '0',
        rate: '0',
        minAmount: result.minMaxHint!.minAmountFloat,
        maxAmount: result.minMaxHint!.maxAmountFloat,
      );
    }
    if (!result.success) {
      throw Exception(result.errorMessage ?? 'Unknown error');
    }
    return null;
  }

  @override
  Future<bool> validateAddress({
    required String currency,
    required String network,
    required String address,
    String? memo,
  }) async {
    return _api.validateAddress(
      currency: currency.toUpperCase(),
      network: network.toUpperCase(),
      address: address,
      memo: memo,
    );
  }

  @override
  Future<OrderInfo?> createOrder(OrderRequest request) async {
    final order = await _api.createOrder(
      fromCurrency: request.fromCurrency,
      fromNetwork: request.fromNetwork,
      toCurrency: request.toCurrency,
      toNetwork: request.toNetwork,
      destinationAddress: request.destinationAddress,
      depositAmount: request.depositAmount,
      destinationAddressMemo: request.destinationAddressMemo,
      refundAddress: request.refundAddress,
      refundAddressMemo: request.refundAddressMemo,
      rate: request.rate,
      networkFee: request.networkFee,
      rateMode: request.rateMode,
      markup: request.markup,
    );
    if (order == null) return null;
    //return _mapOrder(order);
    return OrderInfo(
      orderId: order.orderId,
      type: 'float',
      networkFee: order.claimedNetworkFee,
      platformFee: order.platformFeeAbsolute,
      apiExtraFee: order.claimedNetworkFee,
      payinAddress: order.depositAddress,
      payinExtraId: order.depositAddressMemo,
      payoutAddress: order.destinationAddress,
      payoutExtraId: order.destinationAddressMemo,
      refundAddress: '',
      refundExtraId: null,
      amountExpectedFrom: order.claimedDepositAmount,
      amountExpectedTo: order.amountToGet,
      amountTo: order.amountToGet,
      status: order.completed ? 'finished' : 'waiting',
      currencyFrom: order.fromCurrency?.toLowerCase() ?? '',
      currencyTo: order.toCurrency?.toLowerCase() ?? '',
      payTill: DateTime.now().add(const Duration(minutes: 15)).toUtc().toIso8601String(),
      createdAt: toMsEpoch(order.createdAt),
      payinConfirmations: order.minConfirmationsToTrade ?? 0,
      rawResponse: order.rawJson ?? {}
    );
  }

  @override
  Future<OrderInfoExtended?> getOrderInfo(String orderId, String? destinationAddress) async {
    final order = await _api.getOrderInfo(orderId, destinationAddress: destinationAddress);
    if (order == null) return null;
    final status = resolveQuickexTxStatus(order);
    final amountExpectedFrom = order.claimedDepositAmount;
    final amountExpectedTo = order.amountToGet;
    var rate = order.price;
    if ((rate == null || rate.isEmpty)) {
      final from = double.tryParse(amountExpectedFrom ?? '');
      final to = double.tryParse(amountExpectedTo ?? '');
      if (from != null && to != null && from != 0) {
        rate = (to / from).toString();
      }
    }
    return OrderInfoExtended(
      orderId: order.orderId,
      type: 'float',
      networkFee: order.claimedNetworkFee,
      platformFee: order.platformFeeAbsolute,
      apiExtraFee: null,
      payinAddress: order.depositAddress,
      payinExtraId: order.depositAddressMemo,
      payoutAddress: order.destinationAddress,
      payoutExtraId: order.destinationAddressMemo,
      refundAddress: null,
      refundExtraId: null,
      amountExpectedFrom: amountExpectedFrom,
      amountExpectedTo: amountExpectedTo,
      amountTo: amountExpectedTo,
      status: status,
      currencyFrom: order.fromCurrency?.toLowerCase(),
      currencyTo: order.toCurrency?.toLowerCase(),
      payTill: DateTime.now().add(const Duration(minutes: 15)).toUtc().toIso8601String(),
      createdAt: toMsEpoch(order.createdAt),
      payinConfirmations: int.tryParse(order.minConfirmationsToTrade ?? '') ?? 0,
      rawResponse: order.rawJson ?? {},
      rate: rate,
      moneyReceived: int.tryParse(order.moneyReceived ?? ''),
      moneySent: int.tryParse(order.moneySent ?? ''),
      payinHash: order.payinHash ?? '',
      payoutHashLink: order.payoutHashLink ?? '',
      payoutHash: order.payoutHash ?? '',
      payinExtraIdName: order.payinExtraIdName ?? ''
    );
  }
}
