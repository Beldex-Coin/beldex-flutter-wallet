// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SendStore on SendStoreBase, Store {
  final _$stateAtom = Atom(name: 'SendStoreBase.state');

  @override
  SendingState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SendingState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$fiatAmountAtom = Atom(name: 'SendStoreBase.fiatAmount');

  @override
  String get fiatAmount {
    _$fiatAmountAtom.reportRead();
    return super.fiatAmount;
  }

  @override
  set fiatAmount(String value) {
    _$fiatAmountAtom.reportWrite(value, super.fiatAmount, () {
      super.fiatAmount = value;
    });
  }

  final _$cryptoAmountAtom = Atom(name: 'SendStoreBase.cryptoAmount');

  @override
  String get cryptoAmount {
    _$cryptoAmountAtom.reportRead();
    return super.cryptoAmount;
  }

  @override
  set cryptoAmount(String value) {
    _$cryptoAmountAtom.reportWrite(value, super.cryptoAmount, () {
      super.cryptoAmount = value;
    });
  }

  final _$isValidAtom = Atom(name: 'SendStoreBase.isValid');

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

  final _$errorMessageAtom = Atom(name: 'SendStoreBase.errorMessage');

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

  final _$createStakeAsyncAction = AsyncAction('SendStoreBase.createStake');

  @override
  Future<dynamic> createStake({String address, String amount}) {
    return _$createStakeAsyncAction
        .run(() => super.createStake(address: address, amount: amount));
  }

  final _$createTransactionAsyncAction =
      AsyncAction('SendStoreBase.createTransaction');

  @override
  Future<dynamic> createTransaction(
      {String address, String amount, BeldexTransactionPriority tPriority}) {
    return _$createTransactionAsyncAction.run(() => super.createTransaction(
        address: address, amount: amount, tPriority: tPriority));
  }

  final _$createBnsTransactionAsyncAction =
      AsyncAction('SendStoreBase.createBnsTransaction');

  @override
  Future<dynamic> createBnsTransaction(
      {String owner,
      String backUpOwner,
      String mappingYears,
      String walletAddress,
      String bchatId,
      String belnetId,
      String bnsName,
      BeldexTransactionPriority tPriority}) {
    return _$createBnsTransactionAsyncAction.run(() => super
        .createBnsTransaction(
            owner: owner,
            backUpOwner: backUpOwner,
            mappingYears: mappingYears,
            walletAddress: walletAddress,
            bchatId: bchatId,
            belnetId: belnetId,
            bnsName: bnsName,
            tPriority: tPriority));
  }

  final _$createSweepAllTransactionAsyncAction =
      AsyncAction('SendStoreBase.createSweepAllTransaction');

  @override
  Future<dynamic> createSweepAllTransaction(
      {BeldexTransactionPriority tPriority}) {
    return _$createSweepAllTransactionAsyncAction
        .run(() => super.createSweepAllTransaction(tPriority: tPriority));
  }

  final _$commitTransactionAsyncAction =
      AsyncAction('SendStoreBase.commitTransaction');

  @override
  Future<dynamic> commitTransaction() {
    return _$commitTransactionAsyncAction.run(() => super.commitTransaction());
  }

  final _$_calculateFiatAmountAsyncAction =
      AsyncAction('SendStoreBase._calculateFiatAmount');

  @override
  Future<dynamic> _calculateFiatAmount() {
    return _$_calculateFiatAmountAsyncAction
        .run(() => super._calculateFiatAmount());
  }

  final _$_calculateCryptoAmountAsyncAction =
      AsyncAction('SendStoreBase._calculateCryptoAmount');

  @override
  Future<dynamic> _calculateCryptoAmount() {
    return _$_calculateCryptoAmountAsyncAction
        .run(() => super._calculateCryptoAmount());
  }

  final _$SendStoreBaseActionController =
      ActionController(name: 'SendStoreBase');

  @override
  void setSendAll() {
    final _$actionInfo = _$SendStoreBaseActionController.startAction(
        name: 'SendStoreBase.setSendAll');
    try {
      return super.setSendAll();
    } finally {
      _$SendStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCryptoAmount(String amount) {
    final _$actionInfo = _$SendStoreBaseActionController.startAction(
        name: 'SendStoreBase.changeCryptoAmount');
    try {
      return super.changeCryptoAmount(amount);
    } finally {
      _$SendStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFiatAmount(String amount) {
    final _$actionInfo = _$SendStoreBaseActionController.startAction(
        name: 'SendStoreBase.changeFiatAmount');
    try {
      return super.changeFiatAmount(amount);
    } finally {
      _$SendStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
fiatAmount: ${fiatAmount},
cryptoAmount: ${cryptoAmount},
isValid: ${isValid},
errorMessage: ${errorMessage}
    ''';
  }
}
