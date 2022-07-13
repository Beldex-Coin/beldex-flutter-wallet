import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

final accountSizeNative = beldexApi
    .lookup<NativeFunction<account_size>>('account_size')
    .asFunction<SubaddressSize>();

final accountRefreshNative = beldexApi
    .lookup<NativeFunction<account_refresh>>('account_refresh')
    .asFunction<AccountRefresh>();

final accountGetAllNative = beldexApi
    .lookup<NativeFunction<account_get_all>>('account_get_all')
    .asFunction<AccountGetAll>();

final accountAddNewNative = beldexApi
    .lookup<NativeFunction<account_add_new>>('account_add_row')
    .asFunction<AccountAddNew>();

final accountSetLabelNative = beldexApi
    .lookup<NativeFunction<account_set_label>>('account_set_label_row')
    .asFunction<AccountSetLabel>();

void addAccountSync({String label}) {
  final labelPointer = Utf8.toUtf8(label);
  accountAddNewNative(labelPointer);
  free(labelPointer);
}

void setLabelForAccountSync({int accountIndex, String label}) {
  final labelPointer = Utf8.toUtf8(label);
  accountSetLabelNative(accountIndex, labelPointer);
  free(labelPointer);
}
