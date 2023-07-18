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

// class StakeRowPointer extends Struct {
//   Pointer<Utf8> _masterNodeKey;

//   @Uint64()
//   int _amount;

//   @Uint64()
//   int _unlockHeight;

//   @Uint64()
//   int _awaiting;

//   @Uint64()
//   int _decommissioned;

//   String get masterNodeKey => Utf8.fromUtf8(_masterNodeKey);
//   int get amount => _amount;
//   int get unlockHeight => _unlockHeight > 0 ? _unlockHeight : null;
//   int get awaiting =>  _awaiting ;
//   int get decommissioned => _decommissioned;
// }

// class StakeRow {
//   StakeRow(StakeRowPointer pointer):
//         amount = pointer.amount,
//     masterNodeKey = pointer.masterNodeKey,
//     unlockHeight = pointer.unlockHeight,
//     awaiting = pointer.awaiting,
//     decommissioned = pointer.decommissioned;

//   int amount;
//   String masterNodeKey;
//   int unlockHeight;
//   int awaiting;
//   int decommissioned;

// }
