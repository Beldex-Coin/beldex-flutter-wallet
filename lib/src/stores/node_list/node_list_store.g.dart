// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NodeListStore on NodeListBase, Store {
  final _$nodesAtom = Atom(name: 'NodeListBase.nodes');

  @override
  ObservableList<Node> get nodes {
    _$nodesAtom.reportRead();
    return super.nodes;
  }

  @override
  set nodes(ObservableList<Node> value) {
    _$nodesAtom.reportWrite(value, super.nodes, () {
      super.nodes = value;
    });
  }

  final _$isValidAtom = Atom(name: 'NodeListBase.isValid');

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

  final _$errorMessageAtom = Atom(name: 'NodeListBase.errorMessage');

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

  final _$addNodeAsyncAction = AsyncAction('NodeListBase.addNode');

  @override
  Future<dynamic> addNode(
      {String address, String port, String login, String password}) {
    return _$addNodeAsyncAction.run(() => super.addNode(
        address: address, port: port, login: login, password: password));
  }

  final _$removeAsyncAction = AsyncAction('NodeListBase.remove');

  @override
  Future<dynamic> remove({Node node}) {
    return _$removeAsyncAction.run(() => super.remove(node: node));
  }

  final _$resetAsyncAction = AsyncAction('NodeListBase.reset');

  @override
  Future<dynamic> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  final _$NodeListBaseActionController = ActionController(name: 'NodeListBase');

  @override
  void update() {
    final _$actionInfo =
        _$NodeListBaseActionController.startAction(name: 'NodeListBase.update');
    try {
      return super.update();
    } finally {
      _$NodeListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nodes: ${nodes},
isValid: ${isValid},
errorMessage: ${errorMessage}
    ''';
  }
}
