// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BalanceStore on BalanceStoreBase, Store {
  Computed<String> _$fullBalanceStringComputed;

  @override
  String get fullBalanceString => (_$fullBalanceStringComputed ??=
          Computed<String>(() => super.fullBalanceString,
              name: 'BalanceStoreBase.fullBalanceString'))
      .value;
  Computed<String> _$unlockedBalanceStringComputed;

  @override
  String get unlockedBalanceString => (_$unlockedBalanceStringComputed ??=
          Computed<String>(() => super.unlockedBalanceString,
              name: 'BalanceStoreBase.unlockedBalanceString'))
      .value;
  Computed<String> _$fiatFullBalanceComputed;

  @override
  String get fiatFullBalance => (_$fiatFullBalanceComputed ??= Computed<String>(
          () => super.fiatFullBalance,
          name: 'BalanceStoreBase.fiatFullBalance'))
      .value;
  Computed<String> _$fiatUnlockedBalanceComputed;

  @override
  String get fiatUnlockedBalance => (_$fiatUnlockedBalanceComputed ??=
          Computed<String>(() => super.fiatUnlockedBalance,
              name: 'BalanceStoreBase.fiatUnlockedBalance'))
      .value;

  final _$fullBalanceAtom = Atom(name: 'BalanceStoreBase.fullBalance');

  @override
  int get fullBalance {
    _$fullBalanceAtom.reportRead();
    return super.fullBalance;
  }

  @override
  set fullBalance(int value) {
    _$fullBalanceAtom.reportWrite(value, super.fullBalance, () {
      super.fullBalance = value;
    });
  }

  final _$unlockedBalanceAtom = Atom(name: 'BalanceStoreBase.unlockedBalance');

  @override
  int get unlockedBalance {
    _$unlockedBalanceAtom.reportRead();
    return super.unlockedBalance;
  }

  @override
  set unlockedBalance(int value) {
    _$unlockedBalanceAtom.reportWrite(value, super.unlockedBalance, () {
      super.unlockedBalance = value;
    });
  }

  final _$isReversingAtom = Atom(name: 'BalanceStoreBase.isReversing');

  @override
  bool get isReversing {
    _$isReversingAtom.reportRead();
    return super.isReversing;
  }

  @override
  set isReversing(bool value) {
    _$isReversingAtom.reportWrite(value, super.isReversing, () {
      super.isReversing = value;
    });
  }

  @override
  String toString() {
    return '''
fullBalance: ${fullBalance},
unlockedBalance: ${unlockedBalance},
isReversing: ${isReversing},
fullBalanceString: ${fullBalanceString},
unlockedBalanceString: ${unlockedBalanceString},
fiatFullBalance: ${fiatFullBalance},
fiatUnlockedBalance: ${fiatUnlockedBalance}
    ''';
  }
}
