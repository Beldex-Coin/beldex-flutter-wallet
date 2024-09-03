import 'dart:ffi';

import 'package:ffi/ffi.dart';

class BnsRowPointer extends Struct {

  external Pointer<Utf8> _name;

  external Pointer<Utf8> _nameHash;

  external Pointer<Utf8> _owner;

  external Pointer<Utf8> _backUpOwner;

  external Pointer<Utf8> _encryptedBchatValue;

  external Pointer<Utf8> _encryptedWalletValue;

  external Pointer<Utf8> _encryptedBelnetValue;

  external Pointer<Utf8> _encryptedEthAddrValue;

  external Pointer<Utf8> _valueBchat;

  external Pointer<Utf8> _valueWallet;

  external Pointer<Utf8> _valueBelnet;

  external Pointer<Utf8> _valueEthAddr;

  @Uint64()
  external int _updateHeight;

  @Uint64()
  external int _expirationHeight;

  String get name => _name.toDartString();
  String get nameHash => _nameHash.toDartString();
  String get owner => _owner.toDartString();
  String get backUpOwner => _backUpOwner.toDartString();
  String get encryptedBchatValue => _encryptedBchatValue.toDartString();
  String get encryptedWalletValue => _encryptedWalletValue.toDartString();
  String get encryptedBelnetValue => _encryptedBelnetValue.toDartString();
  String get encryptedEthAddrValue => _encryptedEthAddrValue.toDartString();
  String get valueBchat => _valueBchat.toDartString();
  String get valueWallet => _valueWallet.toDartString();
  String get valueBelnet => _valueBelnet.toDartString();
  String get valueEthAddr => _valueEthAddr.toDartString();
  int get updateHeight => _updateHeight;
  int get expirationHeight => _expirationHeight;
}

class BnsRow {
  BnsRow(BnsRowPointer pointer):
        name = pointer.name,
        nameHash = pointer.nameHash,
        owner = pointer.owner,
        backUpOwner = pointer.backUpOwner,
        encryptedBchatValue = pointer.encryptedBchatValue,
        encryptedWalletValue = pointer.encryptedWalletValue,
        encryptedBelnetValue = pointer.encryptedBelnetValue,
        encryptedEthAddrValue = pointer.encryptedEthAddrValue,
        valueBchat = pointer.valueBchat,
        valueWallet = pointer.valueWallet,
        valueBelnet = pointer.valueBelnet,
        valueEthAddr = pointer.valueEthAddr,
        updateHeight = pointer.updateHeight,
        expirationHeight = pointer.expirationHeight;


  String name;
  String nameHash;
  String owner;
  String backUpOwner;
  String encryptedBchatValue;
  String encryptedWalletValue;
  String encryptedBelnetValue;
  String encryptedEthAddrValue;
  String valueBchat;
  String valueWallet;
  String valueBelnet;
  String valueEthAddr;
  int updateHeight;
  int expirationHeight;

}