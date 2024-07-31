// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
  late final _$nodeAtom =
      Atom(name: 'SettingsStoreBase.node', context: context);

  @override
  Node? get node {
    _$nodeAtom.reportRead();
    return super.node;
  }

  @override
  set node(Node? value) {
    _$nodeAtom.reportWrite(value, super.node, () {
      super.node = value;
    });
  }

  late final _$fiatCurrencyAtom =
      Atom(name: 'SettingsStoreBase.fiatCurrency', context: context);

  @override
  FiatCurrency get fiatCurrency {
    _$fiatCurrencyAtom.reportRead();
    return super.fiatCurrency;
  }

  @override
  set fiatCurrency(FiatCurrency value) {
    _$fiatCurrencyAtom.reportWrite(value, super.fiatCurrency, () {
      super.fiatCurrency = value;
    });
  }

  late final _$transactionPriorityAtom =
      Atom(name: 'SettingsStoreBase.transactionPriority', context: context);

  @override
  BeldexTransactionPriority get transactionPriority {
    _$transactionPriorityAtom.reportRead();
    return super.transactionPriority;
  }

  @override
  set transactionPriority(BeldexTransactionPriority value) {
    _$transactionPriorityAtom.reportWrite(value, super.transactionPriority, () {
      super.transactionPriority = value;
    });
  }

  late final _$balanceDisplayModeAtom =
      Atom(name: 'SettingsStoreBase.balanceDisplayMode', context: context);

  @override
  BalanceDisplayMode? get balanceDisplayMode {
    _$balanceDisplayModeAtom.reportRead();
    return super.balanceDisplayMode;
  }

  @override
  set balanceDisplayMode(BalanceDisplayMode? value) {
    _$balanceDisplayModeAtom.reportWrite(value, super.balanceDisplayMode, () {
      super.balanceDisplayMode = value;
    });
  }

  late final _$balanceDetailAtom =
      Atom(name: 'SettingsStoreBase.balanceDetail', context: context);

  @override
  AmountDetail get balanceDetail {
    _$balanceDetailAtom.reportRead();
    return super.balanceDetail;
  }

  @override
  set balanceDetail(AmountDetail value) {
    _$balanceDetailAtom.reportWrite(value, super.balanceDetail, () {
      super.balanceDetail = value;
    });
  }

  late final _$shouldSaveRecipientAddressAtom = Atom(
      name: 'SettingsStoreBase.shouldSaveRecipientAddress', context: context);

  @override
  bool get shouldSaveRecipientAddress {
    _$shouldSaveRecipientAddressAtom.reportRead();
    return super.shouldSaveRecipientAddress;
  }

  @override
  set shouldSaveRecipientAddress(bool value) {
    _$shouldSaveRecipientAddressAtom
        .reportWrite(value, super.shouldSaveRecipientAddress, () {
      super.shouldSaveRecipientAddress = value;
    });
  }

  late final _$allowBiometricAuthenticationAtom = Atom(
      name: 'SettingsStoreBase.allowBiometricAuthentication', context: context);

  @override
  bool get allowBiometricAuthentication {
    _$allowBiometricAuthenticationAtom.reportRead();
    return super.allowBiometricAuthentication;
  }

  @override
  set allowBiometricAuthentication(bool value) {
    _$allowBiometricAuthenticationAtom
        .reportWrite(value, super.allowBiometricAuthentication, () {
      super.allowBiometricAuthentication = value;
    });
  }

  late final _$enableFiatCurrencyAtom =
      Atom(name: 'SettingsStoreBase.enableFiatCurrency', context: context);

  @override
  bool get enableFiatCurrency {
    _$enableFiatCurrencyAtom.reportRead();
    return super.enableFiatCurrency;
  }

  @override
  set enableFiatCurrency(bool value) {
    _$enableFiatCurrencyAtom.reportWrite(value, super.enableFiatCurrency, () {
      super.enableFiatCurrency = value;
    });
  }

  late final _$isDarkThemeAtom =
      Atom(name: 'SettingsStoreBase.isDarkTheme', context: context);

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  late final _$defaultPinLengthAtom =
      Atom(name: 'SettingsStoreBase.defaultPinLength', context: context);

  @override
  int get defaultPinLength {
    _$defaultPinLengthAtom.reportRead();
    return super.defaultPinLength;
  }

  @override
  set defaultPinLength(int value) {
    _$defaultPinLengthAtom.reportWrite(value, super.defaultPinLength, () {
      super.defaultPinLength = value;
    });
  }

  late final _$languageOverrideAtom =
      Atom(name: 'SettingsStoreBase.languageOverride', context: context);

  @override
  String? get languageOverride {
    _$languageOverrideAtom.reportRead();
    return super.languageOverride;
  }

  @override
  set languageOverride(String? value) {
    _$languageOverrideAtom.reportWrite(value, super.languageOverride, () {
      super.languageOverride = value;
    });
  }

  late final _$setAllowBiometricAuthenticationAsyncAction = AsyncAction(
      'SettingsStoreBase.setAllowBiometricAuthentication',
      context: context);

  @override
  Future<dynamic> setAllowBiometricAuthentication(
      {required bool allowBiometricAuthentication}) {
    return _$setAllowBiometricAuthenticationAsyncAction.run(() => super
        .setAllowBiometricAuthentication(
            allowBiometricAuthentication: allowBiometricAuthentication));
  }

  late final _$setEnableFiatCurrencyAsyncAction =
      AsyncAction('SettingsStoreBase.setEnableFiatCurrency', context: context);

  @override
  Future<dynamic> setEnableFiatCurrency({required bool enableFiatCurrency}) {
    return _$setEnableFiatCurrencyAsyncAction.run(() =>
        super.setEnableFiatCurrency(enableFiatCurrency: enableFiatCurrency));
  }

  late final _$saveDarkThemeAsyncAction =
      AsyncAction('SettingsStoreBase.saveDarkTheme', context: context);

  @override
  Future<dynamic> saveDarkTheme({required bool isDarkTheme}) {
    return _$saveDarkThemeAsyncAction
        .run(() => super.saveDarkTheme(isDarkTheme: isDarkTheme));
  }

  late final _$saveLanguageOverrideAsyncAction =
      AsyncAction('SettingsStoreBase.saveLanguageOverride', context: context);

  @override
  Future<dynamic> saveLanguageOverride(String? language) {
    return _$saveLanguageOverrideAsyncAction
        .run(() => super.saveLanguageOverride(language));
  }

  late final _$setCurrentNodeAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentNode', context: context);

  @override
  Future<dynamic> setCurrentNode(Node node) {
    return _$setCurrentNodeAsyncAction.run(() => super.setCurrentNode(node));
  }

  late final _$setCurrentFiatCurrencyAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentFiatCurrency', context: context);

  @override
  Future<dynamic> setCurrentFiatCurrency({required FiatCurrency currency}) {
    return _$setCurrentFiatCurrencyAsyncAction
        .run(() => super.setCurrentFiatCurrency(currency: currency));
  }

  late final _$setCurrentTransactionPriorityAsyncAction = AsyncAction(
      'SettingsStoreBase.setCurrentTransactionPriority',
      context: context);

  @override
  Future<dynamic> setCurrentTransactionPriority(
      {required BeldexTransactionPriority priority}) {
    return _$setCurrentTransactionPriorityAsyncAction
        .run(() => super.setCurrentTransactionPriority(priority: priority));
  }

  late final _$setCurrentBalanceDisplayModeAsyncAction = AsyncAction(
      'SettingsStoreBase.setCurrentBalanceDisplayMode',
      context: context);

  @override
  Future<dynamic> setCurrentBalanceDisplayMode(
      {required BalanceDisplayMode balanceDisplayMode}) {
    return _$setCurrentBalanceDisplayModeAsyncAction.run(() => super
        .setCurrentBalanceDisplayMode(balanceDisplayMode: balanceDisplayMode));
  }

  late final _$setCurrentBalanceDetailAsyncAction = AsyncAction(
      'SettingsStoreBase.setCurrentBalanceDetail',
      context: context);

  @override
  Future<dynamic> setCurrentBalanceDetail(
      {required AmountDetail balanceDetail}) {
    return _$setCurrentBalanceDetailAsyncAction
        .run(() => super.setCurrentBalanceDetail(balanceDetail: balanceDetail));
  }

  late final _$setSaveRecipientAddressAsyncAction = AsyncAction(
      'SettingsStoreBase.setSaveRecipientAddress',
      context: context);

  @override
  Future<dynamic> setSaveRecipientAddress(
      {required bool shouldSaveRecipientAddress}) {
    return _$setSaveRecipientAddressAsyncAction.run(() => super
        .setSaveRecipientAddress(
            shouldSaveRecipientAddress: shouldSaveRecipientAddress));
  }

  late final _$setDefaultPinLengthAsyncAction =
      AsyncAction('SettingsStoreBase.setDefaultPinLength', context: context);

  @override
  Future<dynamic> setDefaultPinLength({required int pinLength}) {
    return _$setDefaultPinLengthAsyncAction
        .run(() => super.setDefaultPinLength(pinLength: pinLength));
  }

  @override
  String toString() {
    return '''
node: ${node},
fiatCurrency: ${fiatCurrency},
transactionPriority: ${transactionPriority},
balanceDisplayMode: ${balanceDisplayMode},
balanceDetail: ${balanceDetail},
shouldSaveRecipientAddress: ${shouldSaveRecipientAddress},
allowBiometricAuthentication: ${allowBiometricAuthentication},
enableFiatCurrency: ${enableFiatCurrency},
isDarkTheme: ${isDarkTheme},
defaultPinLength: ${defaultPinLength},
languageOverride: ${languageOverride}
    ''';
  }
}
