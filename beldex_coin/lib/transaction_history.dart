import 'dart:async';
import 'dart:ffi';

import 'package:beldex_coin/src/structs/bns_info_row.dart';
import 'package:beldex_coin/src/util/convert_utf8_to_string.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_coin/src/native/transaction_history.dart'
    as transaction_history;

void refreshTransactions() => transaction_history.transactionsRefreshNative();

int countOfTransactions() => transaction_history.transactionsCountNative();

int estimateTransactionFee(int priorityRaw, {int recipients = 1}) =>
    transaction_history.transactionEstimateFeeNative(priorityRaw, recipients);

List<TransactionInfoRow> getAllTransactions() {
  final size = transaction_history.transactionsCountNative();
  final transactionsPointer = transaction_history.transactionsGetAllNative();
  final transactionsAddresses = transactionsPointer.asTypedList(size);

  return transactionsAddresses
      .map((addr) => Pointer<TransactionInfoRow>.fromAddress(addr).ref)
      .toList();
}

void commitTransactionFromPointerAddress({required int address}) =>
    transaction_history.commitTransaction(
        transactionPointer:
            Pointer<PendingTransactionRaw>.fromAddress(address));

PendingTransactionDescription _createTransactionSync(Map args) {
  final address = args['address'] as String;
  final amount = args['amount'] as String;
  final priorityRaw = args['priorityRaw'] as int;
  final accountIndex = args['accountIndex'] as int;

  return transaction_history.createTransactionSync(
      address: address,
      amount: amount,
      priorityRaw: priorityRaw,
      accountIndex: accountIndex);
}

Future<PendingTransactionDescription> createTransaction(
        {required String address,
        required String amount,
        required int priorityRaw,
        int accountIndex = 0}) =>
    compute(_createTransactionSync, {
      'address': address,
      'amount': amount,
      'priorityRaw': priorityRaw,
      'accountIndex': accountIndex
    });

PendingTransactionDescription _createBnsTransactionSync(Map args) {
  final owner = args['owner'] as String;
  final backUpOwner = args['backUpOwner'] as String;
  final mappingYears = args['mappingYears'] as String;
  final bchatId = args['bchatId'] as String;
  final walletAddress = args['walletAddress'] as String;
  final belnetId = args['belnetId'] as String;
  final bnsName = args['bnsName'] as String;
  final priorityRaw = args['priorityRaw'] as int;
  final accountIndex = args['accountIndex'] as int;

  return transaction_history.createBnsTransactionSync(
      owner: owner,
      backUpOwner: backUpOwner,
      mappingYears: mappingYears,
      bchatId: bchatId,
      walletAddress: walletAddress,
      belnetId: belnetId,
      bnsName: bnsName,
      priorityRaw: priorityRaw,
      accountIndex: accountIndex);
}

Future<PendingTransactionDescription> createBnsTransaction(
    {required String owner,
      required String backUpOwner,
      required String mappingYears,
      required String bchatId,
      required String walletAddress,
      required String belnetId,
      required String bnsName,
      required int priorityRaw,
      int accountIndex = 0}) =>
    compute(_createBnsTransactionSync, {
      'owner': owner,
      'backUpOwner': backUpOwner,
      'mappingYears': mappingYears,
      'bchatId': bchatId,
      'walletAddress': walletAddress,
      'belnetId': belnetId,
      'bnsName': bnsName,
      'priorityRaw': priorityRaw,
      'accountIndex': accountIndex
    });

PendingTransactionDescription _createBnsUpdateTransactionSync(Map args) {
  final owner = args['owner'] as String;
  final backUpOwner = args['backUpOwner'] as String;
  final bchatId = args['bchatId'] as String;
  final walletAddress = args['walletAddress'] as String;
  final belnetId = args['belnetId'] as String;
  final bnsName = args['bnsName'] as String;
  final priorityRaw = args['priorityRaw'] as int;
  final accountIndex = args['accountIndex'] as int;

  return transaction_history.createBnsUpdateTransactionSync(
      owner: owner,
      backUpOwner: backUpOwner,
      bchatId: bchatId,
      walletAddress: walletAddress,
      belnetId: belnetId,
      bnsName: bnsName,
      priorityRaw: priorityRaw,
      accountIndex: accountIndex);
}

Future<PendingTransactionDescription> createBnsUpdateTransaction(
    {required String owner,
      required String backUpOwner,
      required String bchatId,
      required String walletAddress,
      required String belnetId,
      required String bnsName,
      required int priorityRaw,
      int accountIndex = 0}) =>
    compute(_createBnsUpdateTransactionSync, {
      'owner': owner,
      'backUpOwner': backUpOwner,
      'bchatId': bchatId,
      'walletAddress': walletAddress,
      'belnetId': belnetId,
      'bnsName': bnsName,
      'priorityRaw': priorityRaw,
      'accountIndex': accountIndex
    });

PendingTransactionDescription _createBnsRenewalTransactionSync(Map args) {
  final bnsName = args['bnsName'] as String;
  final mappingYears = args['mappingYears'] as String;
  final priorityRaw = args['priorityRaw'] as int;
  final accountIndex = args['accountIndex'] as int;

  return transaction_history.createBnsRenewalTransactionSync(
      bnsName: bnsName,
      mappingYears: mappingYears,
      priorityRaw: priorityRaw,
      accountIndex: accountIndex);
}

Future<PendingTransactionDescription> createBnsRenewalTransaction(
    {required String bnsName,
      required String mappingYears,
      required int priorityRaw,
      int accountIndex = 0}) =>
    compute(_createBnsRenewalTransactionSync, {
      'bnsName': bnsName,
      'mappingYears': mappingYears,
      'priorityRaw': priorityRaw,
      'accountIndex': accountIndex
    });

PendingTransactionDescription _createSweepAllTransactionSync(Map args) {
  final priorityRaw = args['priorityRaw'] as int;
  final accountIndex = args['accountIndex'] as int;

  return transaction_history.createSweepAllTransactionSync(
      priorityRaw: priorityRaw,
      accountIndex: accountIndex);
}

Future<PendingTransactionDescription> createSweepAllTransaction(
    {required int priorityRaw,
      int accountIndex = 0}) =>
    compute(_createSweepAllTransactionSync, {
      'priorityRaw': priorityRaw,
      'accountIndex': accountIndex
    });

int countOfBnsTransactions() => transaction_history.bnsCountNative();

List<BnsRow> _getAllBnsSync(int _) {
  final size = countOfBnsTransactions();
  final bnsPointer = transaction_history.bnsGetAllNative();
  final bnsDetails = bnsPointer.asTypedList(size);

  return bnsDetails
      .map((details) => BnsRow(Pointer<BnsRowPointer>.fromAddress(details).ref))
      .toList();
}

Future<List<BnsRow>> getAllBns() =>
    compute<int, List<BnsRow>>(_getAllBnsSync, 0);

bool bnsSetRecord(String bnsName) {
  final bnsNamePointer = bnsName.toNativeUtf8();
  return transaction_history.bnsSetRecordNative(bnsNamePointer) != 0;
}

String _getNameToNameHashSync(String name) {
  final namePointer = name.toNativeUtf8();
  final nameHash = convertUTF8ToString(pointer: transaction_history.getNameToNameHashNative(namePointer));

  calloc.free(namePointer);

  return nameHash;
}

Future<String> getNameToNameHash(String name) =>
    compute<String, String>(_getNameToNameHashSync, name);

