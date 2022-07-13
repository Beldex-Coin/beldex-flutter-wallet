import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final subaddressSizeNative = beldexApi
    .lookup<NativeFunction<subaddress_size>>('subaddress_size')
    .asFunction<SubaddressSize>();

final subaddressRefreshNative = beldexApi
    .lookup<NativeFunction<subaddress_refresh>>('subaddress_refresh')
    .asFunction<SubaddressRefresh>();

final subaddressGetAllNative = beldexApi
    .lookup<NativeFunction<subaddress_get_all>>('subaddress_get_all')
    .asFunction<SubaddressGetAll>();

final subaddressAddNewNative = beldexApi
    .lookup<NativeFunction<subaddress_add_new>>('subaddress_add_row')
    .asFunction<SubaddressAddNew>();

final subaddressSetLabelNative = beldexApi
    .lookup<NativeFunction<subaddress_set_label>>('subaddress_set_label')
    .asFunction<SubaddressSetLabel>();

void addSubaddressSync({int accountIndex, String label}) {
  final labelPointer = Utf8.toUtf8(label);
  subaddressAddNewNative(accountIndex, labelPointer);
  free(labelPointer);
}

void setLabelForSubaddressSync(
    {int accountIndex, int addressIndex, String label}) {
  final labelPointer = Utf8.toUtf8(label);

  subaddressSetLabelNative(accountIndex, addressIndex, labelPointer);
  free(labelPointer);
}
