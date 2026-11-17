import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final subaddressSizeNative = beldexApi
    .lookup<NativeFunction<SubaddressSizeNative>>('subaddress_size')
    .asFunction<SubaddressSize>();

final subaddressRefreshNative = beldexApi
    .lookup<NativeFunction<SubaddressRefreshNative>>('subaddress_refresh')
    .asFunction<SubaddressRefresh>();

final subaddressGetAllNative = beldexApi
    .lookup<NativeFunction<SubaddressGetAllNative>>('subaddress_get_all')
    .asFunction<SubaddressGetAll>();

final subaddressGetAllWithSizeNative = beldexApi
    .lookup<NativeFunction<SubaddressGetAllWithSizeNative>>(
        'subaddress_get_all_with_size')
    .asFunction<SubaddressGetAllWithSize>();

final subaddressFreeAllNative = beldexApi
    .lookup<NativeFunction<SubaddressFreeAllNative>>('subaddress_free_all')
    .asFunction<SubaddressFreeAll>();

final subaddressAddNewNative = beldexApi
    .lookup<NativeFunction<SubaddressAddNewNative>>('subaddress_add_row')
    .asFunction<SubaddressAddNew>();

final subaddressSetLabelNative = beldexApi
    .lookup<NativeFunction<SubaddressSetLabelNative>>('subaddress_set_label')
    .asFunction<SubaddressSetLabel>();

void addSubaddressSync({required int accountIndex, required String label}) {
  final labelPointer = label.toNativeUtf8();
  subaddressAddNewNative(accountIndex, labelPointer);
  calloc.free(labelPointer);
}

void setLabelForSubaddressSync(
    {required int accountIndex,
    required int addressIndex,
    required String label}) {
  final labelPointer = label.toNativeUtf8();

  subaddressSetLabelNative(accountIndex, addressIndex, labelPointer);
  calloc.free(labelPointer);
}
