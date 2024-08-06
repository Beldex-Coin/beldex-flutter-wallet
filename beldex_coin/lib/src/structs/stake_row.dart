import 'dart:ffi';
import 'package:ffi/ffi.dart';

// class StakeRowPointer extends Struct {
//   Pointer<Utf8> _masterNodeKey;

//   @Uint64()
//   int _amount;

//   String get masterNodeKey => Utf8.fromUtf8(_masterNodeKey);
//   int get amount => _amount;
// }

// class StakeRow {
//   StakeRow(StakeRowPointer pointer) {
//     amount = pointer.amount;
//     masterNodeKey = pointer.masterNodeKey;
//   }

//   int amount;
//   String masterNodeKey;
// }

class StakeRowPointer extends Struct {
  external Pointer<Utf8> _masterNodeKey;

  @Uint64()
  external int _amount;

  @Uint64()
  external int _unlock_height;

  @Bool()
  external bool _awaiting;

  @Bool()
  external bool _decommissioned;

  String get masterNodeKey => _masterNodeKey.toDartString();
  int get amount => _amount;
  int? get unlockHeight => _unlock_height > 0 ? _unlock_height : null;
  bool get awaiting =>  _awaiting ;
  bool get decommissioned => _decommissioned;
}

class StakeRow {
  StakeRow(StakeRowPointer pointer):
    amount = pointer.amount,
    masterNodeKey = pointer.masterNodeKey,
    unlockHeight = pointer.unlockHeight,
    awaiting = pointer.awaiting,
    decommissioned = pointer.decommissioned;

  int amount;
  String masterNodeKey;
  int? unlockHeight;
  bool awaiting;
  bool decommissioned;

}
