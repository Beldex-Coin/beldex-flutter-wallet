import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final accountSizeNative = beldexApi
    .lookup<NativeFunction<AccountSizeNative>>('account_size')
    .asFunction<SubaddressSize>();

final accountRefreshNative = beldexApi
    .lookup<NativeFunction<AccountRefreshNative>>('account_refresh')
    .asFunction<AccountRefresh>();

final accountGetAllNative = beldexApi
    .lookup<NativeFunction<AccountGetAllNative>>('account_get_all')
    .asFunction<AccountGetAll>();

final accountGetAllWithSizeNative = beldexApi
    .lookup<NativeFunction<AccountGetAllWithSizeNative>>(
        'account_get_all_with_size')
    .asFunction<AccountGetAllWithSize>();

final accountFreeAllNative = beldexApi
    .lookup<NativeFunction<AccountFreeAllNative>>('account_free_all')
    .asFunction<AccountFreeAll>();

final accountAddNewNative = beldexApi
    .lookup<NativeFunction<AccountAddNewNative>>('account_add_row')
    .asFunction<AccountAddNew>();

final accountSetLabelNative = beldexApi
    .lookup<NativeFunction<AccountSetLabelNative>>('account_set_label_row')
    .asFunction<AccountSetLabel>();

void addAccountSync({required String label}) {
  final labelPointer = label.toNativeUtf8();
  accountAddNewNative(labelPointer);
  calloc.free(labelPointer);
}

void setLabelForAccountSync(
    {required int accountIndex, required String label}) {
  final labelPointer = label.toNativeUtf8();
  accountSetLabelNative(accountIndex, labelPointer);
  calloc.free(labelPointer);
}
