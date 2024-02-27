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

final bnsTransactionCreateNative = beldexApi
    .lookup<NativeFunction<bns_buy>>('bns_buy')
    .asFunction<BnsBuy>();

final sweepAllTransactionCreateNative = beldexApi
    .lookup<NativeFunction<create_sweep_all_transaction>>('create_sweep_all_transaction')
    .asFunction<CreateSweepAllTransaction>();

final bnsCountNative = beldexApi
    .lookup<NativeFunction<bns_count>>('bns_count')
    .asFunction<BnsCount>();

final bnsGetAllNative = beldexApi
    .lookup<NativeFunction<bns_get_all>>('bns_get_all')
    .asFunction<BnsGetAll>();

final bnsSetRecordNative = beldexApi
    .lookup<NativeFunction<bns_set_record>>('bns_set_record')
    .asFunction<BnsSetRecord>();

final getNameToNameHashNative = beldexApi
    .lookup<NativeFunction<get_names_to_namehash>>('get_names_to_namehash')
    .asFunction<GetNameToNameHash>();

final transactionCommitNative = beldexApi
    .lookup<NativeFunction<transaction_commit>>('transaction_commit')
    .asFunction<TransactionCommit>();

final transactionEstimateFeeNative = beldexApi
    .lookup<NativeFunction<transaction_estimate_fee>>(
        'transaction_estimate_fee')
    .asFunction<TransactionEstimateFee>();

PendingTransactionDescription createTransactionSync(
    {String address, String amount, int priorityRaw, int accountIndex = 0}) {
  final addressPointer = Utf8.toUtf8(address);
  final amountPointer = amount != null ? Utf8.toUtf8(amount) : nullptr;
  final errorMessagePointer = allocate<Utf8Box>();
  final pendingTransactionRawPointer = allocate<PendingTransactionRaw>();
  final created = transactionCreateNative(
          addressPointer,
          amountPointer,
          priorityRaw,
          accountIndex,
          errorMessagePointer,
          pendingTransactionRawPointer) !=
      0;

  free(addressPointer);

  if (amountPointer != nullptr) {
    free(amountPointer);
  }

  if (!created) {
    final message = errorMessagePointer.ref.getValue();
    free(errorMessagePointer);
    throw CreationTransactionException(message: message);
  }

  return PendingTransactionDescription(
      amount: pendingTransactionRawPointer.ref.amount,
      fee: pendingTransactionRawPointer.ref.fee,
      hash: pendingTransactionRawPointer.ref.getHash(),
      pointerAddress: pendingTransactionRawPointer.address);
}

void commitTransaction({Pointer<PendingTransactionRaw> transactionPointer}) {
  final errorMessagePointer = allocate<Utf8Box>();
  final isCommited =
      transactionCommitNative(transactionPointer, errorMessagePointer) != 0;

  if (!isCommited) {
    final message = errorMessagePointer.ref.getValue();
    free(errorMessagePointer);
    throw CreationTransactionException(message: message);
  }
}

PendingTransactionDescription createBnsTransactionSync(
    {String owner, String backUpOwner, String mappingYears, String bchatId, String walletAddress, String belnetId, String bnsName, int priorityRaw, int accountIndex = 0}) {
  final ownerPointer = Utf8.toUtf8(owner);
  final backUpOwnerPointer = Utf8.toUtf8(backUpOwner);
  final mappingYearsPointer = Utf8.toUtf8(mappingYears);
  final bchatIdPointer = Utf8.toUtf8(bchatId);
  final walletAddressPointer = Utf8.toUtf8(walletAddress);
  final belnetIdPointer = Utf8.toUtf8(belnetId);
  final bnsNamePointer = Utf8.toUtf8(bnsName);
  final errorMessagePointer = allocate<Utf8Box>();
  final pendingTransactionRawPointer = allocate<PendingTransactionRaw>();
  final created = bnsTransactionCreateNative(
      ownerPointer,
      backUpOwnerPointer,
      mappingYearsPointer,
      bchatIdPointer,
      walletAddressPointer,
      belnetIdPointer,
      bnsNamePointer,
      priorityRaw,
      accountIndex,
      errorMessagePointer,
      pendingTransactionRawPointer) !=
      0;

  free(ownerPointer);
  free(backUpOwnerPointer);
  free(mappingYearsPointer);
  free(bchatIdPointer);
  free(walletAddressPointer);
  free(belnetIdPointer);
  free(bnsNamePointer);

  if (!created) {
    final message = errorMessagePointer.ref.getValue();
    free(errorMessagePointer);
    throw CreationTransactionException(message: message);
  }

  return PendingTransactionDescription(
      amount: pendingTransactionRawPointer.ref.amount,
      fee: pendingTransactionRawPointer.ref.fee,
      hash: pendingTransactionRawPointer.ref.getHash(),
      pointerAddress: pendingTransactionRawPointer.address);
}

PendingTransactionDescription createSweepAllTransactionSync(
    {int priorityRaw, int accountIndex = 0}) {
  final errorMessagePointer = allocate<Utf8Box>();
  final pendingTransactionRawPointer = allocate<PendingTransactionRaw>();
  final created = sweepAllTransactionCreateNative(
      priorityRaw,
      accountIndex,
      errorMessagePointer,
      pendingTransactionRawPointer) !=
      0;

  if (!created) {
    final message = errorMessagePointer.ref.getValue();
    free(errorMessagePointer);
    throw CreationTransactionException(message: message);
  }

  return PendingTransactionDescription(
      amount: pendingTransactionRawPointer.ref.amount,
      fee: pendingTransactionRawPointer.ref.fee,
      hash: pendingTransactionRawPointer.ref.getHash(),
      pointerAddress: pendingTransactionRawPointer.address);
}
