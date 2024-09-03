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

final bnsUpdateTransactionCreateNative = beldexApi
    .lookup<NativeFunction<bns_update>>('bns_update')
    .asFunction<BnsUpdate>();

final bnsRenewalTransactionCreateNative = beldexApi
    .lookup<NativeFunction<bns_renew>>('bns_renew')
    .asFunction<BnsRenew>();

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

  if (amountPointer != nullptr) {
    calloc.free(amountPointer);
  }

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

PendingTransactionDescription createBnsTransactionSync(
    {required String owner, required String backUpOwner, required String mappingYears, required String bchatId, required String walletAddress, required String belnetId, required String ethAddress, required String bnsName, required int priorityRaw, int accountIndex = 0}) {
  final ownerPointer = owner.toNativeUtf8();
  final backUpOwnerPointer = backUpOwner.toNativeUtf8();
  final mappingYearsPointer = mappingYears.toNativeUtf8();
  final bchatIdPointer = bchatId.toNativeUtf8();
  final walletAddressPointer = walletAddress.toNativeUtf8();
  final belnetIdPointer = belnetId.toNativeUtf8();
  final ethAddressPointer = ethAddress.toNativeUtf8();
  final bnsNamePointer = bnsName.toNativeUtf8();
  final pendingTransactionRawPointer = calloc<PendingTransactionRaw>();
  final result = bnsTransactionCreateNative(
      ownerPointer,
      backUpOwnerPointer,
      mappingYearsPointer,
      bchatIdPointer,
      walletAddressPointer,
      belnetIdPointer,
      ethAddressPointer,
      bnsNamePointer,
      priorityRaw,
      accountIndex,
      pendingTransactionRawPointer);

  calloc.free(ownerPointer);
  calloc.free(backUpOwnerPointer);
  calloc.free(mappingYearsPointer);
  calloc.free(bchatIdPointer);
  calloc.free(walletAddressPointer);
  calloc.free(belnetIdPointer);
  calloc.free(ethAddressPointer);
  calloc.free(bnsNamePointer);

  if (result.good)
    return PendingTransactionDescription(
        amount: pendingTransactionRawPointer.ref.amount,
        fee: pendingTransactionRawPointer.ref.fee,
        hash: pendingTransactionRawPointer.ref.getHash(),
        pointerAddress: pendingTransactionRawPointer.address);

  calloc.free(pendingTransactionRawPointer);
  throw CreationTransactionException(message: result.errorString());
}

PendingTransactionDescription createBnsUpdateTransactionSync(
    {required String owner, required String backUpOwner, required String bchatId, required String walletAddress, required String belnetId, required String ethAddress, required String bnsName, required int priorityRaw, int accountIndex = 0}) {
  final ownerPointer = owner.toNativeUtf8();
  final backUpOwnerPointer = backUpOwner.toNativeUtf8();
  final bchatIdPointer = bchatId.toNativeUtf8();
  final walletAddressPointer = walletAddress.toNativeUtf8();
  final belnetIdPointer = belnetId.toNativeUtf8();
  final ethAddressPointer = ethAddress.toNativeUtf8();
  final bnsNamePointer = bnsName.toNativeUtf8();
  final pendingTransactionRawPointer = calloc<PendingTransactionRaw>();
  final result = bnsUpdateTransactionCreateNative(
      ownerPointer,
      backUpOwnerPointer,
      bchatIdPointer,
      walletAddressPointer,
      belnetIdPointer,
      ethAddressPointer,
      bnsNamePointer,
      priorityRaw,
      accountIndex,
      pendingTransactionRawPointer);

  calloc.free(ownerPointer);
  calloc.free(backUpOwnerPointer);
  calloc.free(bchatIdPointer);
  calloc.free(walletAddressPointer);
  calloc.free(belnetIdPointer);
  calloc.free(ethAddressPointer);
  calloc.free(bnsNamePointer);

  if (result.good)
    return PendingTransactionDescription(
        amount: pendingTransactionRawPointer.ref.amount,
        fee: pendingTransactionRawPointer.ref.fee,
        hash: pendingTransactionRawPointer.ref.getHash(),
        pointerAddress: pendingTransactionRawPointer.address);

  calloc.free(pendingTransactionRawPointer);
  throw CreationTransactionException(message: result.errorString());
}

PendingTransactionDescription createBnsRenewalTransactionSync(
    {required String bnsName, required String mappingYears, required int priorityRaw, int accountIndex = 0}) {
  final bnsNamePointer = bnsName.toNativeUtf8();
  final mappingYearsPointer = mappingYears.toNativeUtf8();
  final pendingTransactionRawPointer = calloc<PendingTransactionRaw>();
  final result = bnsRenewalTransactionCreateNative(
      bnsNamePointer,
      mappingYearsPointer,
      priorityRaw,
      accountIndex,
      pendingTransactionRawPointer);

  calloc.free(bnsNamePointer);
  calloc.free(mappingYearsPointer);


  if (result.good)
    return PendingTransactionDescription(
        amount: pendingTransactionRawPointer.ref.amount,
        fee: pendingTransactionRawPointer.ref.fee,
        hash: pendingTransactionRawPointer.ref.getHash(),
        pointerAddress: pendingTransactionRawPointer.address);

  calloc.free(pendingTransactionRawPointer);
  throw CreationTransactionException(message: result.errorString());
}

PendingTransactionDescription createSweepAllTransactionSync(
    {required int priorityRaw, int accountIndex = 0}) {
  final pendingTransactionRawPointer = calloc<PendingTransactionRaw>();
  final result = sweepAllTransactionCreateNative(
      priorityRaw,
      accountIndex,
      pendingTransactionRawPointer);

  if (result.good)
    return PendingTransactionDescription(
        amount: pendingTransactionRawPointer.ref.amount,
        fee: pendingTransactionRawPointer.ref.fee,
        hash: pendingTransactionRawPointer.ref.getHash(),
        pointerAddress: pendingTransactionRawPointer.address);

  calloc.free(pendingTransactionRawPointer);
  throw CreationTransactionException(message: result.errorString());
}
