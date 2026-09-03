import 'dart:io';

import 'package:beldex_wallet/src/swap/database/swap_database_manager.dart';
import 'package:beldex_wallet/src/swap/exchange/models/order_info.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter/cupertino.dart';

import '../exchange/changelly/changelly_exchange_service.dart';
import '../exchange/quickex/quickex_exchange_service.dart';
import '../util/utils.dart';

class GetTransactionsProvider with ChangeNotifier {
  GetTransactionsModel? data;

  bool loading = true;
  bool _disposed = false;
  final ChangellyExchangeService _changellyApi = ChangellyExchangeService();
  final QuickexExchangeService _quickexApi = QuickexExchangeService();
  String? _error;
  String? get error => _error;

  void getTransactionsData(context, Map<String, String> params,
      {String? exchangeName}) async {
    loading = true;
    _error = null;
    final exchange = exchangeName ?? 'changelly';
    try {
      if (exchange == 'quickex') {
        final id = params['id'];
        final orderId = int.tryParse(id ?? '');
        if (orderId != null) {
          String? destAddress = params['destinationAddress'] ?? params['destination_address'];
          if (destAddress == null || destAddress.isEmpty) {
            final record = await SwapDatabaseManager.instance.getTxnById('$orderId');
            if (record != null) {
              destAddress = record['payout_address'] as String?;
            }
          }
          final order = await _quickexApi.getOrderInfo(orderId, destAddress);
          if (order != null) {
            data = GetTransactionsModel(
              result: [mapOrderToTransaction(order)],
              payTill: order.payTill,
              orderInfo: order
            );
          }
        }
        return;
      }
      final orderId = params['id'];
      if (orderId != null) {
        String? destAddress = params['destinationAddress'] ?? params['destination_address'];
        if (destAddress == null || destAddress.isEmpty) {
          final record = await SwapDatabaseManager.instance.getTxnById('$orderId');
          if (record != null) {
            destAddress = record['payout_address'] as String?;
          }
        }
        final order = await _changellyApi.getOrderInfo(orderId, destAddress);
        if (order != null) {
          data = GetTransactionsModel(
            result: [mapOrderToTransaction(order)],
            payTill: order.payTill,
            orderInfo: order
          );
        }
      }
    } on SocketException catch (e) {
      print('get transactions api SocketException: Failed to connect: $e');
      //_error = "No internet connection.";
    } catch (e) {
      print('get transactions api Unexpected error: $e');
      //_error = "Unexpected error: ${e.toString()}";
    } finally {
      loading = false;
      if(!_disposed) notifyListeners();
    }
  }

  GetTransactionResult mapOrderToTransaction(OrderInfoExtended order) {
    return GetTransactionResult(
      id: '${order.orderId}',
      status: order.status,
      type: 'float',
      currencyFrom: order.currencyFrom,
      currencyTo: order.currencyTo,
      payinAddress: order.payinAddress,
      payinExtraId: order.payinExtraId,
      payoutAddress: order.payoutAddress,
      payoutExtraId: order.payoutExtraId,
      amountExpectedFrom: order.amountExpectedFrom,
      amountExpectedTo: order.amountExpectedTo,
      amountTo: order.amountTo,
      networkFee: order.networkFee,
      payinConfirmations: order.payinConfirmations is num
          ? order.payinConfirmations
          : int.tryParse('${order.payinConfirmations ?? ''}') ?? 0,
      createdAt: order.createdAt is int ? order.createdAt : order.createdAt != null ? toMsEpoch(order.createdAt) : null,
      rate: order.rate,
      moneyReceived: order.moneyReceived,
      moneySent: order.moneySent,
      payinHash: order.payinHash,
      payoutHashLink: order.payoutHashLink,
      payoutHash: order.payoutHash,
      payinExtraIdName: order.payinExtraIdName,
    );
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