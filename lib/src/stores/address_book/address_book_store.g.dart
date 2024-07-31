// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressBookStore on AddressBookStoreBase, Store {
  late final _$contactListAtom =
      Atom(name: 'AddressBookStoreBase.contactList', context: context);

  @override
  List<Contact> get contactList {
    _$contactListAtom.reportRead();
    return super.contactList;
  }

  @override
  set contactList(List<Contact> value) {
    _$contactListAtom.reportWrite(value, super.contactList, () {
      super.contactList = value;
    });
  }

  late final _$isValidAtom =
      Atom(name: 'AddressBookStoreBase.isValid', context: context);

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
      Atom(name: 'AddressBookStoreBase.errorMessage', context: context);

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

  late final _$addAsyncAction =
      AsyncAction('AddressBookStoreBase.add', context: context);

  @override
  Future<dynamic> add({required Contact contact}) {
    return _$addAsyncAction.run(() => super.add(contact: contact));
  }

  late final _$updateContactListAsyncAction =
      AsyncAction('AddressBookStoreBase.updateContactList', context: context);

  @override
  Future<dynamic> updateContactList() {
    return _$updateContactListAsyncAction.run(() => super.updateContactList());
  }

  late final _$updateAsyncAction =
      AsyncAction('AddressBookStoreBase.update', context: context);

  @override
  Future<dynamic> update({required Contact contact}) {
    return _$updateAsyncAction.run(() => super.update(contact: contact));
  }

  late final _$deleteAsyncAction =
      AsyncAction('AddressBookStoreBase.delete', context: context);

  @override
  Future<dynamic> delete({required Contact contact}) {
    return _$deleteAsyncAction.run(() => super.delete(contact: contact));
  }

  @override
  String toString() {
    return '''
contactList: ${contactList},
isValid: ${isValid},
errorMessage: ${errorMessage}
    ''';
  }
}
