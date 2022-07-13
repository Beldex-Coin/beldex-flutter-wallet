import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:beldex_coin/src/native/subaddress_list.dart' as subaddress_list;
import 'package:beldex_coin/beldex_coin_structs.dart';

void refreshSubaddresses({int accountIndex}) =>
    subaddress_list.subaddressRefreshNative(accountIndex);

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

Future addSubaddress({int accountIndex, String label}) async =>
    compute<Map<String, Object>, void>(
        _addSubaddress, {'accountIndex': accountIndex, 'label': label});

Future setLabelForSubaddress(
        {int accountIndex, int addressIndex, String label}) =>
    compute<Map<String, Object>, void>(_setLabelForSubaddress, {
      'accountIndex': accountIndex,
      'addressIndex': addressIndex,
      'label': label
    });
