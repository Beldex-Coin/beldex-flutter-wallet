import 'dart:ffi';

import 'package:ffi/ffi.dart';

class BnsRowPointer extends Struct {

  Pointer<Utf8> _name;

  Pointer<Utf8> _nameHash;

  Pointer<Utf8> _owner;

  Pointer<Utf8> _backUpOwner;

  Pointer<Utf8> _encryptedBchatValue;

  Pointer<Utf8> _encryptedWalletValue;

  Pointer<Utf8> _encryptedBelnetValue;

  Pointer<Utf8> _valueBchat;

  Pointer<Utf8> _valueWallet;

  Pointer<Utf8> _valueBelnet;

  @Uint64()
  int _updateHeight;

  @Uint64()
  int _expirationHeight;

  String get name => Utf8.fromUtf8(_name);
  String get nameHash => Utf8.fromUtf8(_nameHash);
  String get owner => Utf8.fromUtf8(_owner);
  String get backUpOwner => Utf8.fromUtf8(_backUpOwner);
  String get encryptedBchatValue => Utf8.fromUtf8(_encryptedBchatValue);
  String get encryptedWalletValue => Utf8.fromUtf8(_encryptedWalletValue);
  String get encryptedBelnetValue => Utf8.fromUtf8(_encryptedBelnetValue);
  String get valueBchat => Utf8.fromUtf8(_valueBchat);
  String get valueWallet => Utf8.fromUtf8(_valueWallet);
  String get valueBelnet => Utf8.fromUtf8(_valueBelnet);
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
        valueBchat = pointer.valueBchat,
        valueWallet = pointer.valueWallet,
        valueBelnet = pointer.valueBelnet,
        updateHeight = pointer.updateHeight,
        expirationHeight = pointer.expirationHeight;


  String name;
  String nameHash;
  String owner;
  String backUpOwner;
  String encryptedBchatValue;
  String encryptedWalletValue;
  String encryptedBelnetValue;
  String valueBchat;
  String valueWallet;
  String valueBelnet;
  int updateHeight;
  int expirationHeight;

}