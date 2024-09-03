// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SendStore on SendStoreBase, Store {
  late final _$stateAtom = Atom(name: 'SendStoreBase.state', context: context);

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

  late final _$fiatAmountAtom =
      Atom(name: 'SendStoreBase.fiatAmount', context: context);

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

  late final _$cryptoAmountAtom =
      Atom(name: 'SendStoreBase.cryptoAmount', context: context);

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

  late final _$isValidAtom =
      Atom(name: 'SendStoreBase.isValid', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'SendStoreBase.errorMessage', context: context);

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

  late final _$createStakeAsyncAction =
      AsyncAction('SendStoreBase.createStake', context: context);

  @override
  Future<dynamic> createStake(
      {required String address, String? amount, required AppLocalizations l10n}) {
    return _$createStakeAsyncAction.run(
        () => super.createStake(address: address, amount: amount, l10n: l10n));
  }

  late final _$createTransactionAsyncAction =
      AsyncAction('SendStoreBase.createTransaction', context: context);

  @override
  Future<dynamic> createTransaction(
      {required String address,
      String? amount,
      BeldexTransactionPriority? tPriority,
      required AppLocalizations t}) {
    return _$createTransactionAsyncAction.run(() => super.createTransaction(
        address: address, amount: amount, tPriority: tPriority, t: t));
  }

  late final _$createBnsTransactionAsyncAction =
      AsyncAction('SendStoreBase.createBnsTransaction', context: context);

  @override
  Future<dynamic> createBnsTransaction(
      {required String owner,
      required String backUpOwner,
      required String mappingYears,
      required String walletAddress,
      required String bchatId,
      required String belnetId,
      required String ethAddress,
      required String bnsName,
      required BeldexTransactionPriority tPriority}) {
    return _$createBnsTransactionAsyncAction.run(() => super
        .createBnsTransaction(
            owner: owner,
            backUpOwner: backUpOwner,
            mappingYears: mappingYears,
            walletAddress: walletAddress,
            bchatId: bchatId,
            belnetId: belnetId,
            ethAddress: ethAddress,
            bnsName: bnsName,
            tPriority: tPriority));
  }

  late final _$createBnsUpdateTransactionAsyncAction =
      AsyncAction('SendStoreBase.createBnsUpdateTransaction', context: context);

  @override
  Future<dynamic> createBnsUpdateTransaction(
      {required String owner,
      required String backUpOwner,
      required String walletAddress,
      required String bchatId,
      required String belnetId,
      required String ethAddress,
      required String bnsName,
      required BeldexTransactionPriority tPriority}) {
    return _$createBnsUpdateTransactionAsyncAction.run(() => super
        .createBnsUpdateTransaction(
            owner: owner,
            backUpOwner: backUpOwner,
            walletAddress: walletAddress,
            bchatId: bchatId,
            belnetId: belnetId,
            ethAddress: ethAddress,
            bnsName: bnsName,
            tPriority: tPriority));
  }

  late final _$createBnsRenewalTransactionAsyncAction = AsyncAction(
      'SendStoreBase.createBnsRenewalTransaction',
      context: context);

  @override
  Future<dynamic> createBnsRenewalTransaction(
      {required String bnsName,
      required String mappingYears,
      required BeldexTransactionPriority tPriority}) {
    return _$createBnsRenewalTransactionAsyncAction.run(() => super
        .createBnsRenewalTransaction(
            bnsName: bnsName,
            mappingYears: mappingYears,
            tPriority: tPriority));
  }

  late final _$createSweepAllTransactionAsyncAction =
      AsyncAction('SendStoreBase.createSweepAllTransaction', context: context);

  @override
  Future<dynamic> createSweepAllTransaction(
      {required BeldexTransactionPriority tPriority}) {
    return _$createSweepAllTransactionAsyncAction
        .run(() => super.createSweepAllTransaction(tPriority: tPriority));
  }

  late final _$commitTransactionAsyncAction =
      AsyncAction('SendStoreBase.commitTransaction', context: context);

  @override
  Future<dynamic> commitTransaction() {
    return _$commitTransactionAsyncAction.run(() => super.commitTransaction());
  }

  late final _$_calculateFiatAmountAsyncAction =
      AsyncAction('SendStoreBase._calculateFiatAmount', context: context);

  @override
  Future<dynamic> _calculateFiatAmount() {
    return _$_calculateFiatAmountAsyncAction
        .run(() => super._calculateFiatAmount());
  }

  late final _$_calculateCryptoAmountAsyncAction =
      AsyncAction('SendStoreBase._calculateCryptoAmount', context: context);

  @override
  Future<dynamic> _calculateCryptoAmount() {
    return _$_calculateCryptoAmountAsyncAction
        .run(() => super._calculateCryptoAmount());
  }

  late final _$SendStoreBaseActionController =
      ActionController(name: 'SendStoreBase', context: context);

  @override
  void setSendAll(AppLocalizations t) {
    final _$actionInfo = _$SendStoreBaseActionController.startAction(
        name: 'SendStoreBase.setSendAll');
    try {
      return super.setSendAll(t);
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
