import 'dart:ffi';

import 'package:ffi/ffi.dart';

class TransactionInfoRow extends Struct {
  @Uint64()
  external int amount;

  @Uint64()
  external int fee;

  @Uint64()
  external int blockHeight;

  @Uint64()
  external int confirmations;

  @Uint32()
  external int subaddrAccount;

  @Int8()
  external int direction;

  @Int8()
  external int isPending;

/*  @Int8()
  external int isStake;

  @Uint64()
  external int transferAmount;*/

  external Pointer<Utf8> hash;

  external Pointer<Utf8> paymentId;

  @Int64()
  external int datetime;

  int getDatetime() => datetime;
  int getAmount() => amount >= 0 ? amount : -amount;
  //int? getTransferAmount() => transferAmount > 0 ? transferAmount : transferAmount < 0 ? -amount : null;
  int getFee() => fee >= 0 ? fee : -fee;
  bool getIsPending() => isPending != 0;
  String getHash() => hash.toDartString();
  String getPaymentId() => paymentId.toDartString();
}
