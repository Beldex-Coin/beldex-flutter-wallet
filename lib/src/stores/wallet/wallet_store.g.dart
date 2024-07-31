// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletStore on WalletStoreBase, Store {
  late final _$addressAtom =
      Atom(name: 'WalletStoreBase.address', context: context);

  @override
  String? get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String? value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$nameAtom = Atom(name: 'WalletStoreBase.name', context: context);

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

  late final _$subaddressAtom =
      Atom(name: 'WalletStoreBase.subaddress', context: context);

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

  late final _$accountAtom =
      Atom(name: 'WalletStoreBase.account', context: context);

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

  late final _$typeAtom = Atom(name: 'WalletStoreBase.type', context: context);

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

  late final _$amountValueAtom =
      Atom(name: 'WalletStoreBase.amountValue', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'WalletStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$reconnectAsyncAction =
      AsyncAction('WalletStoreBase.reconnect', context: context);

  @override
  Future<dynamic> reconnect() {
    return _$reconnectAsyncAction.run(() => super.reconnect());
  }

  late final _$rescanAsyncAction =
      AsyncAction('WalletStoreBase.rescan', context: context);

  @override
  Future<dynamic> rescan({required int restoreHeight}) {
    return _$rescanAsyncAction
        .run(() => super.rescan(restoreHeight: restoreHeight));
  }

  late final _$startSyncAsyncAction =
      AsyncAction('WalletStoreBase.startSync', context: context);

  @override
  Future<dynamic> startSync() {
    return _$startSyncAsyncAction.run(() => super.startSync());
  }

  late final _$connectToNodeAsyncAction =
      AsyncAction('WalletStoreBase.connectToNode', context: context);

  @override
  Future<dynamic> connectToNode({required Node? node}) {
    return _$connectToNodeAsyncAction
        .run(() => super.connectToNode(node: node));
  }

  late final _$WalletStoreBaseActionController =
      ActionController(name: 'WalletStoreBase', context: context);

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
  void validateAmount(String amount, AppLocalizations t) {
    final _$actionInfo = _$WalletStoreBaseActionController.startAction(
        name: 'WalletStoreBase.validateAmount');
    try {
      return super.validateAmount(amount, t);
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
errorMessage: ${errorMessage}
    ''';
  }
}
