import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:beldex_coin/src/native/subaddress_list.dart' as subaddress_list;
import 'package:beldex_coin/beldex_coin_structs.dart';

void _refreshSubaddresses(Map<String, dynamic> args) {
  final accountIndex = args['accountIndex'] as int;

  subaddress_list.subaddressRefreshNative(accountIndex);
}

/// Runs the blocking native subaddress refresh on a background isolate so the
/// wallet mutex wait cannot stall the UI thread.
Future<void> refreshSubaddresses({required int accountIndex}) =>
    compute<Map<String, Object>, void>(
        _refreshSubaddresses, {'accountIndex': accountIndex});

List<SubaddressRow> getAllSubaddresses() {
  final size = subaddress_list.subaddressSizeNative();
  final subaddressAddressesPointer = subaddress_list.subaddressGetAllNative();
  final subaddressAddresses = subaddressAddressesPointer.asTypedList(size);

  return subaddressAddresses
      .map((addr) => Pointer<SubaddressRow>.fromAddress(addr).ref)
      .toList();
}

void _addSubaddress(Map<String, dynamic> args) {
  final label = args['label'] as String;
  final accountIndex = args['accountIndex'] as int;

  subaddress_list.addSubaddressSync(accountIndex: accountIndex, label: label);
}

void _setLabelForSubaddress(Map<String, dynamic> args) {
  final label = args['label'] as String;
  final accountIndex = args['accountIndex'] as int;
  final addressIndex = args['addressIndex'] as int;

  subaddress_list.setLabelForSubaddressSync(
      accountIndex: accountIndex, addressIndex: addressIndex, label: label);
}

Future addSubaddress({required int accountIndex, required String label}) async =>
    compute<Map<String, Object>, void>(
        _addSubaddress, {'accountIndex': accountIndex, 'label': label});

Future setLabelForSubaddress(
        {required int accountIndex, required int addressIndex, required String label}) =>
    compute<Map<String, Object>, void>(_setLabelForSubaddress, {
      'accountIndex': accountIndex,
      'addressIndex': addressIndex,
      'label': label
    });
