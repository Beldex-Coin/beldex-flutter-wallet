import 'dart:ffi';
import 'package:ffi/ffi.dart';

class StakeRowPointer extends Struct {
  Pointer<Utf8> _masterNodeKey;

  @Uint64()
  int _amount;

  String get masterNodeKey => Utf8.fromUtf8(_masterNodeKey);
  int get amount => _amount;
}

class StakeRow {
  StakeRow(StakeRowPointer pointer) {
    amount = pointer.amount;
    masterNodeKey = pointer.masterNodeKey;
  }

  int amount;
  String masterNodeKey;
}
