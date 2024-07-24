import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/native/stake.dart' as stake_native;

int countOfTransactions() => stake_native.stakeCountNative();

List<StakeRow> _getAllStakesSync(int _) {
  final size = countOfTransactions();
  final stakePointer = stake_native.stakeGetAllNative();
  final stakeAddresses = stakePointer.asTypedList(size);

  return stakeAddresses
      .map((addr) => StakeRow(Pointer<StakeRowPointer>.fromAddress(addr).ref))
      .toList();
}

Future<List<StakeRow>> getAllStakes() =>
    compute<int, List<StakeRow>>(_getAllStakesSync, 0);

PendingTransactionDescription _createStakeSync(Map args) {
  final masterNodeKey = args['master_node_key'] as String;
  final amount = args['amount'] as String;

  return stake_native.createStakeSync(masterNodeKey, amount);
}

Future<PendingTransactionDescription> createStake(
        String masterNodeKey, String amount) =>
    compute(_createStakeSync,
        {'master_node_key': masterNodeKey, 'amount': amount});

bool canRequestUnstake(String masterNodeKey) {
  final masterNodeKeyPointer = masterNodeKey.toNativeUtf8();
  return stake_native.canRequestUnstakeNative(masterNodeKeyPointer) != 0;
}

void _submitStakeUnlockSync(Map args) {
  final masterNodeKey = args['master_node_key'] as String;
  stake_native.submitStakeUnlockSync(masterNodeKey);
}

Future<void> submitStakeUnlock(String masterNodeKey) =>
    compute(_submitStakeUnlockSync, {'master_node_key': masterNodeKey});
