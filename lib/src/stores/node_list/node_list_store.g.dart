// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NodeListStore on NodeListBase, Store {
  late final _$nodesAtom = Atom(name: 'NodeListBase.nodes', context: context);

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

  late final _$isValidAtom =
      Atom(name: 'NodeListBase.isValid', context: context);

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
      Atom(name: 'NodeListBase.errorMessage', context: context);

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

  late final _$addNodeAsyncAction =
      AsyncAction('NodeListBase.addNode', context: context);

  @override
  Future<dynamic> addNode(
      {required String address,
      String? port,
      required String login,
      required String password}) {
    return _$addNodeAsyncAction.run(() => super.addNode(
        address: address, port: port, login: login, password: password));
  }

  late final _$removeAsyncAction =
      AsyncAction('NodeListBase.remove', context: context);

  @override
  Future<dynamic> remove({required Node node}) {
    return _$removeAsyncAction.run(() => super.remove(node: node));
  }

  late final _$resetAsyncAction =
      AsyncAction('NodeListBase.reset', context: context);

  @override
  Future<dynamic> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  late final _$NodeListBaseActionController =
      ActionController(name: 'NodeListBase', context: context);

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
