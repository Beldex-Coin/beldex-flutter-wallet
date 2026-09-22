import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:beldex_coin/src/native/account_list.dart' as account_list;

import 'package:beldex_coin/beldex_coin_structs.dart';

void _refreshAccounts(void _) => account_list.accountRefreshNative();

/// Runs the blocking native account refresh on a background isolate so the
/// wallet mutex wait cannot stall the UI thread.
Future<void> refreshAccounts() =>
    compute<void, void>(_refreshAccounts, null);

List<AccountRow> getAllAccount() {
  final size = account_list.accountSizeNative();
  final accountAddressesPointer = account_list.accountGetAllNative();
  final accountAddresses = accountAddressesPointer.asTypedList(size);

  return accountAddresses
      .map((addr) => Pointer<AccountRow>.fromAddress(addr).ref)
      .toList();
}

void _addAccount(String label) => account_list.addAccountSync(label: label);

void _setLabelForAccount(Map<String, dynamic> args) {
  final label = args['label'] as String;
  final accountIndex = args['accountIndex'] as int;

  account_list.setLabelForAccountSync(label: label, accountIndex: accountIndex);
}

Future<void> addAccount({required String label}) async => compute(_addAccount, label);

Future<void> setLabelForAccount({required int accountIndex, required String label}) async =>
    compute(
        _setLabelForAccount, {'accountIndex': accountIndex, 'label': label});
