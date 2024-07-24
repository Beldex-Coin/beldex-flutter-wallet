// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_restoration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletRestorationStore on WalletRestorationStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'WalletRestorationStoreBase.state', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'WalletRestorationStoreBase.errorMessage', context: context);

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

  late final _$isValidAtom =
      Atom(name: 'WalletRestorationStoreBase.isValid', context: context);

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

  late final _$seedAtom =
      Atom(name: 'WalletRestorationStoreBase.seed', context: context);

  @override
  List<MnemoticItem>? get seed {
    _$seedAtom.reportRead();
    return super.seed;
  }

  @override
  set seed(List<MnemoticItem>? value) {
    _$seedAtom.reportWrite(value, super.seed, () {
      super.seed = value;
    });
  }

  late final _$restoreFromSeedAsyncAction = AsyncAction(
      'WalletRestorationStoreBase.restoreFromSeed',
      context: context);

  @override
  Future<dynamic> restoreFromSeed(
      {required String name, String? seed, required int restoreHeight}) {
    return _$restoreFromSeedAsyncAction.run(() => super
        .restoreFromSeed(name: name, seed: seed, restoreHeight: restoreHeight));
  }

  late final _$restoreFromKeysAsyncAction = AsyncAction(
      'WalletRestorationStoreBase.restoreFromKeys',
      context: context);

  @override
  Future<dynamic> restoreFromKeys(
      {required String name,
      required String language,
      required String address,
      required String viewKey,
      required String spendKey,
      required int restoreHeight}) {
    return _$restoreFromKeysAsyncAction.run(() => super.restoreFromKeys(
        name: name,
        language: language,
        address: address,
        viewKey: viewKey,
        spendKey: spendKey,
        restoreHeight: restoreHeight));
  }

  late final _$WalletRestorationStoreBaseActionController =
      ActionController(name: 'WalletRestorationStoreBase', context: context);

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
  void validateSeed(List<MnemoticItem>? seed, AppLocalizations l10n) {
    final _$actionInfo = _$WalletRestorationStoreBaseActionController
        .startAction(name: 'WalletRestorationStoreBase.validateSeed');
    try {
      return super.validateSeed(seed, l10n);
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
