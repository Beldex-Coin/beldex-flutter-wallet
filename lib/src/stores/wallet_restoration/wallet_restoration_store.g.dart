// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_restoration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletRestorationStore on WalletRestorationStoreBase, Store {
  final _$stateAtom = Atom(name: 'WalletRestorationStoreBase.state');

  @override
  WalletRestorationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(WalletRestorationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: 'WalletRestorationStoreBase.errorMessage');

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

  final _$isValidAtom = Atom(name: 'WalletRestorationStoreBase.isValid');

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

  final _$seedAtom = Atom(name: 'WalletRestorationStoreBase.seed');

  @override
  List<MnemoticItem> get seed {
    _$seedAtom.reportRead();
    return super.seed;
  }

  @override
  set seed(List<MnemoticItem> value) {
    _$seedAtom.reportWrite(value, super.seed, () {
      super.seed = value;
    });
  }

  final _$restoreFromSeedAsyncAction =
      AsyncAction('WalletRestorationStoreBase.restoreFromSeed');

  @override
  Future<dynamic> restoreFromSeed(
      {String name, String seed, int restoreHeight}) {
    return _$restoreFromSeedAsyncAction.run(() => super
        .restoreFromSeed(name: name, seed: seed, restoreHeight: restoreHeight));
  }

  final _$restoreFromKeysAsyncAction =
      AsyncAction('WalletRestorationStoreBase.restoreFromKeys');

  @override
  Future<dynamic> restoreFromKeys(
      {String name,
      String language,
      String address,
      String viewKey,
      String spendKey,
      int restoreHeight}) {
    return _$restoreFromKeysAsyncAction.run(() => super.restoreFromKeys(
        name: name,
        language: language,
        address: address,
        viewKey: viewKey,
        spendKey: spendKey,
        restoreHeight: restoreHeight));
  }

  final _$WalletRestorationStoreBaseActionController =
      ActionController(name: 'WalletRestorationStoreBase');

  @override
  void setSeed(List<MnemoticItem> seed) {
    final _$actionInfo = _$WalletRestorationStoreBaseActionController
        .startAction(name: 'WalletRestorationStoreBase.setSeed');
    try {
      return super.setSeed(seed);
    } finally {
      _$WalletRestorationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateSeed(List<MnemoticItem> seed) {
    final _$actionInfo = _$WalletRestorationStoreBaseActionController
        .startAction(name: 'WalletRestorationStoreBase.validateSeed');
    try {
      return super.validateSeed(seed);
    } finally {
      _$WalletRestorationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage},
isValid: ${isValid},
seed: ${seed}
    ''';
  }
}
