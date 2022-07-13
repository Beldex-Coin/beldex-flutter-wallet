// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionFilterStore on TransactionFilterStoreBase, Store {
  final _$displayIncomingAtom =
      Atom(name: 'TransactionFilterStoreBase.displayIncoming');

  @override
  bool get displayIncoming {
    _$displayIncomingAtom.reportRead();
    return super.displayIncoming;
  }

  @override
  set displayIncoming(bool value) {
    _$displayIncomingAtom.reportWrite(value, super.displayIncoming, () {
      super.displayIncoming = value;
    });
  }

  final _$displayOutgoingAtom =
      Atom(name: 'TransactionFilterStoreBase.displayOutgoing');

  @override
  bool get displayOutgoing {
    _$displayOutgoingAtom.reportRead();
    return super.displayOutgoing;
  }

  @override
  set displayOutgoing(bool value) {
    _$displayOutgoingAtom.reportWrite(value, super.displayOutgoing, () {
      super.displayOutgoing = value;
    });
  }

  final _$startDateAtom = Atom(name: 'TransactionFilterStoreBase.startDate');

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  final _$endDateAtom = Atom(name: 'TransactionFilterStoreBase.endDate');

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  final _$TransactionFilterStoreBaseActionController =
      ActionController(name: 'TransactionFilterStoreBase');

  @override
  void toggleIncoming() {
    final _$actionInfo = _$TransactionFilterStoreBaseActionController
        .startAction(name: 'TransactionFilterStoreBase.toggleIncoming');
    try {
      return super.toggleIncoming();
    } finally {
      _$TransactionFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleOutgoing() {
    final _$actionInfo = _$TransactionFilterStoreBaseActionController
        .startAction(name: 'TransactionFilterStoreBase.toggleOutgoing');
    try {
      return super.toggleOutgoing();
    } finally {
      _$TransactionFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStartDate(DateTime date) {
    final _$actionInfo = _$TransactionFilterStoreBaseActionController
        .startAction(name: 'TransactionFilterStoreBase.changeStartDate');
    try {
      return super.changeStartDate(date);
    } finally {
      _$TransactionFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEndDate(DateTime date) {
    final _$actionInfo = _$TransactionFilterStoreBaseActionController
        .startAction(name: 'TransactionFilterStoreBase.changeEndDate');
    try {
      return super.changeEndDate(date);
    } finally {
      _$TransactionFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
displayIncoming: ${displayIncoming},
displayOutgoing: ${displayOutgoing},
startDate: ${startDate},
endDate: ${endDate}
    ''';
  }
}
