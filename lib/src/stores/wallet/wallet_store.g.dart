// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletStore on WalletStoreBase, Store {
  final _$addressAtom = Atom(name: 'WalletStoreBase.address');

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$nameAtom = Atom(name: 'WalletStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$subaddressAtom = Atom(name: 'WalletStoreBase.subaddress');

  @override
  Subaddress get subaddress {
    _$subaddressAtom.reportRead();
    return super.subaddress;
  }

  @override
  set subaddress(Subaddress value) {
    _$subaddressAtom.reportWrite(value, super.subaddress, () {
      super.subaddress = value;
    });
  }

  final _$accountAtom = Atom(name: 'WalletStoreBase.account');

  @override
  Account get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(Account value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  final _$typeAtom = Atom(name: 'WalletStoreBase.type');

  @override
  CryptoCurrency get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(CryptoCurrency value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$amountValueAtom = Atom(name: 'WalletStoreBase.amountValue');

  @override
  String get amountValue {
    _$amountValueAtom.reportRead();
    return super.amountValue;
  }

  @override
  set amountValue(String value) {
    _$amountValueAtom.reportWrite(value, super.amountValue, () {
      super.amountValue = value;
    });
  }

  final _$isValidAtom = Atom(name: 'WalletStoreBase.isValid');

  @override
  bool get isValid {
    _$isValidAtom.reportRead();
    return super.isValid;
  }

  @override
  set isValid(bool value) {
    _$isValidAtom.reportWrite(value, super.isValid, () {
      super.isValid = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'WalletStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$reconnectAsyncAction = AsyncAction('WalletStoreBase.reconnect');

  @override
  Future<dynamic> reconnect() {
    return _$reconnectAsyncAction.run(() => super.reconnect());
  }

  final _$rescanAsyncAction = AsyncAction('WalletStoreBase.rescan');

  @override
  Future<dynamic> rescan({int restoreHeight}) {
    return _$rescanAsyncAction
        .run(() => super.rescan(restoreHeight: restoreHeight));
  }

  final _$startSyncAsyncAction = AsyncAction('WalletStoreBase.startSync');

  @override
  Future<dynamic> startSync() {
    return _$startSyncAsyncAction.run(() => super.startSync());
  }

  final _$connectToNodeAsyncAction =
      AsyncAction('WalletStoreBase.connectToNode');

  @override
  Future<dynamic> connectToNode({Node node}) {
    return _$connectToNodeAsyncAction
        .run(() => super.connectToNode(node: node));
  }

  final _$WalletStoreBaseActionController =
      ActionController(name: 'WalletStoreBase');

  @override
  void setAccount(Account account) {
    final _$actionInfo = _$WalletStoreBaseActionController.startAction(
        name: 'WalletStoreBase.setAccount');
    try {
      return super.setAccount(account);
    } finally {
      _$WalletStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSubaddress(Subaddress subaddress) {
    final _$actionInfo = _$WalletStoreBaseActionController.startAction(
        name: 'WalletStoreBase.setSubaddress');
    try {
      return super.setSubaddress(subaddress);
    } finally {
      _$WalletStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangedAmountValue(String value) {
    final _$actionInfo = _$WalletStoreBaseActionController.startAction(
        name: 'WalletStoreBase.onChangedAmountValue');
    try {
      return super.onChangedAmountValue(value);
    } finally {
      _$WalletStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAmount(String amount) {
    final _$actionInfo = _$WalletStoreBaseActionController.startAction(
        name: 'WalletStoreBase.validateAmount');
    try {
      return super.validateAmount(amount);
    } finally {
      _$WalletStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
address: ${address},
name: ${name},
subaddress: ${subaddress},
account: ${account},
type: ${type},
amountValue: ${amountValue},
isValid: ${isValid},
errorMessage: ${errorMessage}
    ''';
  }
}
