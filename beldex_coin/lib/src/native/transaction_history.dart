import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/exceptions/creation_transaction_exception.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/structs/ut8_box.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final transactionsRefreshNative = beldexApi
    .lookup<NativeFunction<transactions_refresh>>('transactions_refresh')
    .asFunction<TransactionsRefresh>();

final transactionsCountNative = beldexApi
    .lookup<NativeFunction<transactions_count>>('transactions_count')
    .asFunction<TransactionsCount>();

final transactionsGetAllNative = beldexApi
    .lookup<NativeFunction<transactions_get_all>>('transactions_get_all')
    .asFunction<TransactionsGetAll>();

final transactionCreateNative = beldexApi
    .lookup<NativeFunction<transaction_create>>('transaction_create')
    .asFunction<TransactionCreate>();

final transactionCommitNative = beldexApi
    .lookup<NativeFunction<transaction_commit>>('transaction_commit')
    .asFunction<TransactionCommit>();

final transactionEstimateFeeNative = beldexApi
    .lookup<NativeFunction<transaction_estimate_fee>>(
        'transaction_estimate_fee')
    .asFunction<TransactionEstimateFee>();

PendingTransactionDescription createTransactionSync(
    {required String address, required String? amount, required int priorityRaw, int accountIndex = 0}) {
  final addressPointer = address.toNativeUtf8();
  final amountPointer = amount != null ? amount.toNativeUtf8() : nullptr;
  final pendingTransactionRawPointer = calloc<PendingTransactionRaw>();
  final result = transactionCreateNative(
          addressPointer,
          amountPointer,
          priorityRaw,
          accountIndex,
          pendingTransactionRawPointer);

  calloc.free(addressPointer);
  if (amountPointer != nullptr)
    calloc.free(amountPointer);

  if (result.good)
    return PendingTransactionDescription(
        amount: pendingTransactionRawPointer.ref.amount,
        fee: pendingTransactionRawPointer.ref.fee,
        hash: pendingTransactionRawPointer.ref.getHash(),
        pointerAddress: pendingTransactionRawPointer.address);

  calloc.free(pendingTransactionRawPointer);
  throw CreationTransactionException(message: result.errorString());
}

void commitTransaction({required Pointer<PendingTransactionRaw> transactionPointer}) {
  final result = transactionCommitNative(transactionPointer);

  if (!result.good)
    throw CreationTransactionException(message: result.errorString());
}
