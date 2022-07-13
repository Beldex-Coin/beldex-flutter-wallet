import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/exceptions/creation_transaction_exception.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/structs/ut8_box.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final stakeCountNative = beldexApi
    .lookup<NativeFunction<stake_count>>('stake_count')
    .asFunction<StakeCount>();

final stakeGetAllNative = beldexApi
    .lookup<NativeFunction<stake_get_all>>('stake_get_all')
    .asFunction<StakeGetAll>();

final stakeCreateNative = beldexApi
    .lookup<NativeFunction<stake_create>>('stake_create')
    .asFunction<StakeCreate>();

final canRequestUnstakeNative = beldexApi
    .lookup<NativeFunction<can_request_unstake>>('can_request_stake_unlock')
    .asFunction<CanRequestUnstake>();

final submitStakeUnlockNative = beldexApi
    .lookup<NativeFunction<submit_stake_unlock>>('submit_stake_unlock')
    .asFunction<SubmitStakeUnlock>();

PendingTransactionDescription createStakeSync(
    String masterNodeKey, String amount) {
  final masterNodeKeyPointer = Utf8.toUtf8(masterNodeKey);
  final amountPointer = Utf8.toUtf8(amount);
  final errorMessagePointer = allocate<Utf8Box>();
  final pendingTransactionRawPointer = allocate<PendingTransactionRaw>();
  final created = stakeCreateNative(masterNodeKeyPointer, amountPointer,
          errorMessagePointer, pendingTransactionRawPointer) !=
      0;

  free(masterNodeKeyPointer);

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

PendingTransactionDescription submitStakeUnlockSync(String masterNodeKey) {
  final masterNodeKeyPointer = Utf8.toUtf8(masterNodeKey);
  final errorMessagePointer = allocate<Utf8Box>();
  final pendingTransactionRawPointer = allocate<PendingTransactionRaw>();
  final created = submitStakeUnlockNative(masterNodeKeyPointer,
          errorMessagePointer, pendingTransactionRawPointer) !=
      0;

  free(masterNodeKeyPointer);

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
