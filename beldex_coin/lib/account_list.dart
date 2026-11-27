import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:beldex_coin/src/native/account_list.dart' as account_list;

import 'package:beldex_coin/beldex_coin_structs.dart';

void _refreshAccounts(void _) => account_list.accountRefreshNative();

/// Runs the blocking native account refresh on a background isolate so the
/// wallet mutex wait cannot stall the UI thread.
Future<void> refreshAccounts() => compute<void, void>(_refreshAccounts, null);

List<AccountRow> getAllAccount() {
  final sizePointer = calloc<Int32>();
  var accountAddressesPointer = Pointer<Int64>.fromAddress(0);

  try {
    accountAddressesPointer =
        account_list.accountGetAllWithSizeNative(sizePointer);
    final size = sizePointer.value;
    if (size < 0) {
      throw StateError('Native account list returned an invalid size: $size');
    }
    if (size == 0) {
      return [];
    }
    if (accountAddressesPointer.address == 0) {
      throw StateError('Native account list returned a null row array.');
    }

    final accountAddresses = accountAddressesPointer.asTypedList(size);
    return accountAddresses.map((address) {
      final row = Pointer<_NativeAccountRow>.fromAddress(address).ref;
      return AccountRow(id: row.id, label: row.label.toDartString());
    }).toList();
  } finally {
    account_list.accountFreeAllNative(
        accountAddressesPointer, sizePointer.value);
    calloc.free(sizePointer);
  }
}

base class _NativeAccountRow extends Struct {
  @Int64()
  external int id;
  external Pointer<Utf8> label;
}

void _addAccount(String label) => account_list.addAccountSync(label: label);

void _setLabelForAccount(Map<String, dynamic> args) {
  final label = args['label'] as String;
  final accountIndex = args['accountIndex'] as int;

  account_list.setLabelForAccountSync(label: label, accountIndex: accountIndex);
}

Future<void> addAccount({required String label}) async =>
    compute(_addAccount, label);

Future<void> setLabelForAccount(
        {required int accountIndex, required String label}) async =>
    compute(
        _setLabelForAccount, {'accountIndex': accountIndex, 'label': label});
